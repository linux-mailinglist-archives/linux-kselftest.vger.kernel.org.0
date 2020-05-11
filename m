Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1785D1CDAA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEKNBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 09:01:43 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56596 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbgEKNBn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 09:01:43 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT9s5TLleRVczAA--.23S3;
        Mon, 11 May 2020 20:59:38 +0800 (CST)
References: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 0/4] Fix some issues about kmod
Cc:     yangtiezhu@loongson.cn, Markus.Elfring@web.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lixuefeng@loongson.cn
To:     akpm@linux-foundation.org, jeyu@kernel.org, mcgrof@kernel.org,
        shuah@kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9b50d2b1-2fb4-10a1-5966-5458507a9b05@loongson.cn>
Date:   Mon, 11 May 2020 20:59:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT9s5TLleRVczAA--.23S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
        5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeV
        CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2
        V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUb0D73UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Could you please apply the following three patches?

[v4,1/4] selftests: kmod: Use variable NAME in kmod_test_0001()
https://lore.kernel.org/patchwork/patch/1227980/

[v4,2/4] kmod: Remove redundant "be an" in the comment
https://lore.kernel.org/patchwork/patch/1227982/

[v4,4/4] test_kmod: Avoid potential double free in trigger_config_run_type()
https://lore.kernel.org/patchwork/patch/1227978/

Thanks,
Tiezhu Yang

