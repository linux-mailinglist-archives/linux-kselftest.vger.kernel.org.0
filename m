Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2C624450
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKJOaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 09:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKJOaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 09:30:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4225E6;
        Thu, 10 Nov 2022 06:30:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6532C22B1F;
        Thu, 10 Nov 2022 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668090599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSoHOmzTZ7gyugDunrFhNTTXk+eDJFT7wutdb5qE/V4=;
        b=yXF3lDzzMVRtYMe3I/VsD4IKEm75UaJ5QfI3RonL1KcnZUfc5xdfKFc+6i5UkElQYF0XPr
        eLcYy9cRJNaU5lh+l7wj843bJBbi9jRw3sSEzpoOFwGiQzWEIMwdKxwljGTABQITsExefl
        CPDsRYmO5RI6AjbLNaHnf+4ll4Ni3jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668090599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSoHOmzTZ7gyugDunrFhNTTXk+eDJFT7wutdb5qE/V4=;
        b=EgyI714T6tUZz1AjDUTvOwd/8MuzWjnjMmnnJQSzKTpLOXqVATmznpl+KRDKmOwaKSnp8O
        lU/jZqa3lka1YEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E0FC1332F;
        Thu, 10 Nov 2022 14:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nDlMBucKbWOvJAAAMHmgww
        (envelope-from <mdoucha@suse.cz>); Thu, 10 Nov 2022 14:29:59 +0000
Message-ID: <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
Date:   Thu, 10 Nov 2022 15:29:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
To:     Minchan Kim <minchan@kernel.org>, Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
Content-Language: en-US
From:   Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y2l3vJb1y2Jynf50@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07. 11. 22 22:25, Minchan Kim wrote:
> On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
>> Hi all,
>>
>> following bug is trying to workaround an error on ppc64le, where
>> zram01.sh LTP test (there is also kernel selftest
>> tools/testing/selftests/zram/zram01.sh, but LTP test got further
>> updates) has often mem_used_total 0 although zram is already filled.
> 
> Hi, Petr,
> 
> Is it happening on only ppc64le?
> 
> Is it a new regression? What kernel version did you use?

Hi,
I've reported the same issue on kernels 4.12.14 and 5.3.18 internally to 
our kernel developers at SUSE. The bugreport is not public but I'll copy 
the bug description here:

New version of LTP test zram01 found a sysfile issue with zram devices 
mounted using VFAT filesystem. When when all available space is filled, 
e.g. by `dd if=/dev/zero of=/mnt/zram0/file`, the corresponding sysfile 
/sys/block/zram0/mm_stat will report that the compressed data size on 
the device is 0 and total memory usage is also 0. LTP test zram01 uses 
these values to calculate compression ratio, which results in division 
by zero.

The issue is specific to PPC64LE architecture and the VFAT filesystem. 
No other tested filesystem has this issue and I could not reproduce it 
on other archs (s390 not tested). The issue appears randomly about every 
3 test runs on SLE-15SP2 and 15SP3 (kernel 5.3). It appears less 
frequently on SLE-12SP5 (kernel 4.12). Other SLE version were not tested 
with the new test version yet. The previous version of the test did not 
check the VFAT filesystem on zram devices.

I've tried to debug the issue and collected some interesting data (all 
values come from zram device with 25M size limit and zstd compression 
algorithm):
- mm_stat values are correct after mkfs.vfat:
65536      220    65536 26214400    65536        0        0        0

- mm_stat values stay correct after mount:
65536      220    65536 26214400    65536        0        0        0

- the bug is triggered by filling the filesystem to capacity (using dd):
4194304        0        0 26214400   327680       64        0        0

- adding `sleep 1` between `dd` and reading mm_stat does not help
- adding sync between `dd` and reading mm_stat appears to fix the issue:
26214400     2404   262144 26214400   327680      399        0        0

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

