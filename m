Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC0197180
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 02:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgC3ApS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Mar 2020 20:45:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34176 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727549AbgC3ApS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Mar 2020 20:45:18 -0400
X-IronPort-AV: E=Sophos;i="5.72,322,1580745600"; 
   d="scan'208";a="87771264"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Mar 2020 08:45:16 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 73303406AB15;
        Mon, 30 Mar 2020 08:35:00 +0800 (CST)
Received: from localhost.localdomain (10.167.226.81) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 30 Mar 2020 08:45:18 +0800
Subject: Re: runqslower build failed on Debian9
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
To:     Andrii Nakryiko <andriin@fb.com>
CC:     <linux-kselftest@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <60b05d23-6352-b978-3bf7-5a86466bb297@cn.fujitsu.com>
 <c1025a74-1d80-5127-2b0a-87465d3dbcd0@fb.com>
 <84a70348-62e3-728b-d934-28e902d40fd0@cn.fujitsu.com>
Message-ID: <da95b852-e556-1b56-42eb-b97e1826710c@cn.fujitsu.com>
Date:   Mon, 30 Mar 2020 08:46:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <84a70348-62e3-728b-d934-28e902d40fd0@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.81]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 73303406AB15.A7336
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Something wrong with my smtp and this email missed.

Send again.


On 3/27/20 11:09 AM, Liu Yiding wrote:
> Hi, Andrii.
>
> Thanks for your prompt reply!
>
> Please check attatchment for my_btf.bin.
>
>
> On 3/27/20 4:28 AM, Andrii Nakryiko wrote:
>> Would you be able to share BTF of vmlinux that is used to generate 
>> vmlinux.h? Please run in verbose mode: `make V=1` and search for 
>> `bpftool btf dump file` command. It should point either to
>> /sys/kernel/btf/vmlinux or some other location, depending on how 
>> things are set up on your side.
>>
>> If it's /sys/kernel/btf/vmlinux, you can just `cat 
>> /sys/kernel/btf/vmlinux > my_btf.bin`. If it's some other file, 
>> easiest would be to just share that file. If not, it's possible to 
>> extract .BTF ELF section, let me know if you need help with that. 
>
-- 
Best Regards.
Liu Yiding



