Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD621AFF6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDTBHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Apr 2020 21:07:22 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53906 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgDTBHU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Apr 2020 21:07:20 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH2rB9ZxegukpAA--.17S3;
        Mon, 20 Apr 2020 09:07:15 +0800 (CST)
Subject: Re: [PATCH 4/4] test_kmod: Avoid potential double free in
 trigger_config_run_type()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-kselftest@vger.kernel.org
References: <53bf9145-db17-9123-2489-540eaf2733a6@web.de>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a917be73-202b-8e38-6039-cccda3e59a5f@loongson.cn>
Date:   Mon, 20 Apr 2020 09:07:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <53bf9145-db17-9123-2489-540eaf2733a6@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxH2rB9ZxegukpAA--.17S3
X-Coremail-Antispam: 1UD129KBjvdXoWrWr4xJrWxZw4xXFyxWr4rXwb_yoWxArc_ur
        y3JFykX3yUCasxuFsrW393JrZIgay5X3s5WrnrGay2kwnFvan7uaykJrsaqw4rG39xJrsI
        krZYvr9rZr17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/19/2020 01:23 AM, Markus Elfring wrote:
>> It should set config->test_fs instead of config->test_driver as NULL
>> after kfree_const(config->test_fs) to avoid potential double free.
> I suggest to improve this change description.
>
> * How do you think about a wording variant like the following?
>
>    Reset the member “test_fs” of the test configuration after a call
>    of the function “kfree_const” to a null pointer so that a double
>    memory release will not be performed.
>
> * Would you like to add the tag “Fixes”?
>
> Regards,
> Markus

OK, I will send a v2 patch with the updated commit message and "Fixes" tag.

Thanks,
Tiezhu Yang

