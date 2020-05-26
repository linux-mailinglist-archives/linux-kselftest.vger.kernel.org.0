Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A001A376D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgDIPvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 11:51:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgDIPvE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 11:51:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so5168664pgo.0;
        Thu, 09 Apr 2020 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fG1SOvMroxrFtO8docHj5UPu60hC1vUMj8BuUzyfP48=;
        b=CRZs5kBpDlET7XJKfHlriFJl8/84TKFfU72HCijp0bVrW6OGxRfnLcLcdl32dZVTJ0
         OrhJHiNYwZuU6G4DcS+DrfTX0sF24mCJ37DjOecvlh3j38zNN8YOjvnl6WOZtcQEf7U0
         Cv1l0AkMHPNR/YEyTV3hNhIgKAdVY7Y9YLM3KfjPCpTxEPDB9Pg5KgC9Pd+3BR8rCH+y
         eORzsvT9QdT/YyZ/hKbaS0vOYV0tF1a5OsKy/oH6gwKeKJ9R6V4zJ3VrEa7HSjRnXaAo
         8BTMXt4IaMHNLE5zJj587vAcXwKfs8kZ4G74L40TOFTrB2A3YJWf7VJX/N03ovnr8bIQ
         bDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fG1SOvMroxrFtO8docHj5UPu60hC1vUMj8BuUzyfP48=;
        b=QRDARHorg6P2BOh5lWlCX9Lz/ByNjpTyfByAXJ6kLpzLwrw1t3CCTfT5k6CuAEXGAX
         Jmo6ct/OffQZkPr9N6MEHvYixn/6B6YJntvg0yO7AbN2FUEcfQeyJUi7TypEleJm0vqL
         VwDmZJmGS5YT6Z5pF7xeb1MDOMTPNh9LIpEXYaKdkikxExFj25j7heDW0lCXMXAEyT/2
         fHF+uAKJZtZ3oz7JdOzmU7RH/Qw9ODy25dhxeJgl3Lw65v1MUpIQmyoxitfFx+uGwo4m
         o/s27vz2w6GGB89Y9nGS6EyX6yXM5X8AWyP/6qEIhUAuur7Nr2RlboLdNHrnBHrsJ9q4
         OQ3Q==
X-Gm-Message-State: AGi0PubM/OtlVPepqVfGsch4shHF5piR6mMcV7O+tHE/BU9OKon2hvNh
        tM10WToxWLLxWu8b/UXPB8kToao6
X-Google-Smtp-Source: APiQypJ0UM1jODYiND0JG/NeXqppdatj1F3BAaW4oJRNDwxSuqR60KrA6Ps+TKIZb1dpqRok+I0d3Q==
X-Received: by 2002:a62:aa08:: with SMTP id e8mr144455pff.267.1586447461104;
        Thu, 09 Apr 2020 08:51:01 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id u21sm2515392pjy.8.2020.04.09.08.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:50:59 -0700 (PDT)
Date:   Thu, 9 Apr 2020 08:50:57 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux- stable <stable@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        inux-block@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: zram: Unable to handle kernel NULL pointer dereference at
 virtual address
Message-ID: <20200409155057.GA247701@google.com>
References: <CA+G9fYtNOQ7Cp=u3oyS5cVmzzF+GzGmU1DTxSL5hwCH+mYT4yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtNOQ7Cp=u3oyS5cVmzzF+GzGmU1DTxSL5hwCH+mYT4yw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Naresh,

On Wed, Apr 08, 2020 at 04:56:58PM +0530, Naresh Kamboju wrote:
> While running kselftest zram test case on qemu arm this kernel warning.
> This has been reported on stable rc 5.4, 5.5 and 5.6 and mainline and next.
> 
> [ 1277.176612] kselftest: Running tests in zram
> [ 1277.375891] zram: Added device: zram0
> [ 1278.505516] zram0: detected capacity change from 0 to 2097152
> [ 1278.545644] 8<--- cut here ---
> [ 1278.547036] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [ 1278.550494] pgd = 385dcf93
> [ 1278.551571] [00000000] *pgd=68116003, *pmd=1352f5003
> [ 1278.553632] Internal error: Oops: 207 [#1] SMP ARM
> [ 1278.555463] Modules linked in: zram act_mirred cls_u32 nf_tables
> nfnetlink sch_etf sit ip_tables x_tables cls_bpf sch_fq algif_hash
> crc32_arm_ce sha2_arm_ce sha256_arm sha1_arm_ce sha1_arm aes_arm_ce
> crypto_simd fuse [last unloaded: test_user_copy]
> [ 1278.564699] CPU: 0 PID: 11598 Comm: mkfs.ext4 Not tainted 5.4.31-rc2 #1
> [ 1278.567731] Hardware name: Generic DT based system
> [ 1278.569977] PC is at zs_map_object+0xc8/0x2ac
> [ 1278.572001] LR is at 0xe6058000
> [ 1278.573603] pc : [<c0696858>]    lr : [<e6058000>]    psr: 600d0013
> [ 1278.576602] sp : e6059a40  ip : 00000000  fp : e6059a84
> [ 1278.579066] r10: 00000000  r9 : 00000002  r8 : 00000000
> [ 1278.581600] r7 : ecff9000  r6 : ffed05e0  r5 : c20086c8  r4 : e4907000
> [ 1278.584686] r3 : ecec95e0  r2 : c2842040  r1 : 00000030  r0 : 39aca001
> [ 1278.587767] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [ 1278.591171] Control: 30c5383d  Table: 66f8d780  DAC: fffffffd
> [ 1278.593918] Process mkfs.ext4 (pid: 11598, stack limit = 0xb0888730)
> [ 1278.596941] Stack: (0xe6059a40 to 0xe605a000)
> [ 1278.599017] 9a40: c08c1e80 efec95e0 e6059aa8 e6059a58 c04228c4
> bf1b31a7 e6059a84 e64bf400
> [ 1278.602884] 9a60: d89c2000 00000008 e544f000 e5713680 c20086c8
> e544f000 e6059adc e6059a88
> [ 1278.606739] 9a80: bf0bad70 c069679c 00000000 00000001 ed496460
> 00000001 e55e8000 00017e3b
> [ 1278.610593] 9aa0: 00000001 c20086c8 00000041 bf1b31a7 00000000
> 00000000 00001000 00000001
> [ 1278.614445] 9ac0: 00001000 e182d840 e64bf400 00001000 e6059b34
> e6059ae0 bf0bb56c bf0ba9a4
> [ 1278.618312] 9ae0: e182d840 c20086c8 c04cdd4c 00000000 c20086c8
> 00000000 ed496460 00001000
> [ 1278.622227] 9b00: 00000000 bf1b31a7 c064f294 e55e8000 ffffe000
> e182d840 00000000 c2043828
> [ 1278.626154] 9b20: ffffffff c21db2a0 e6059b94 e6059b38 c091fc7c
> bf0bb3d8 c040f2a0 c040dca4
> [ 1278.629802] 9b40: c20086c8 00000000 c20086c8 e6059b54 c06ee318
> 00000000 00000000 00000000
> [ 1278.633759] 9b60: 00000000 bf1b31a7 c04cdf38 c20086c8 e182d840
> 00000801 00000800 00000008
> [ 1278.637713] 9b80: 00000000 e58dfc68 e6059c04 e6059b98 c091ffc0
> c091fb70 c05713c8 e182d840
> [ 1278.641609] 9ba0: e54dc038 00001000 00000000 c06ee318 e54dc04c
> 00000000 e6059c04 e6059bc8
> [ 1278.645549] 9bc0: c06ee0b0 c04cdb0c 00000001 00000000 c06ee318
> bf1b31a7 00000000 e5a88580
> [ 1278.649501] 9be0: e182d840 00000801 00000800 00000000 00000000
> e58dfc68 e6059c2c e6059c08
> [ 1278.653423] 9c00: c06ee354 c091ff78 00000001 e5a88580 e5a88580
> e6059e58 00000800 00000000
> [ 1278.657215] 9c20: e6059ca4 e6059c30 c06ee700 c06ee1c4 e6059e58
> 00000000 c06eeda0 e6059c48
> [ 1278.661069] 9c40: c040dd24 c06f248c 00001000 c06ec500 c1bb920c
> 00000000 c20086c8 e6059e58
> [ 1278.664917] 9c60: 00000800 ed496460 c140993c 00000000 e6059ca4
> bf1b31a7 c05713c8 e58dfc68
> [ 1278.668758] 9c80: ed496460 600d0013 e58dfd0c c06f2564 00000001
> 00000000 e6059cec e6059ca8
> [ 1278.672618] 9ca0: c06eeda0 c06ee390 c06ec500 00000000 c06f2564
> 00000001 e6059e58 c06f248c
> [ 1278.676447] 9cc0: e54df048 e58dfdd8 00000002 c1b9e48c e6059d5c
> 00000001 e6059e58 e58dfdd8
> [ 1278.680295] 9ce0: e6059cfc e6059cf0 c06f2564 c06eec1c e6059d14
> e6059d00 c05f9820 c06f254c
> [ 1278.684100] 9d00: ed496460 00000002 e6059dcc e6059d18 c05fd4bc
> c05f9808 00000002 00000001
> [ 1278.689217] 9d20: e6059d5c 00000000 00000001 c20086c8 c21dafe7
> 00000002 00000000 ffffffff
> [ 1278.693068] 9d40: e58dfdd8 c05f97fc c20086f4 ffffe000 c21dd694
> 00000010 000001f4 c06f000f
> [ 1278.696929] 9d60: ed6dcb50 ed496460 ed723590 ed6ef630 ed6e97e0
> ed728360 ed726890 ed5b03d0
> [ 1278.700775] 9d80: ed7841c0 ed451070 ed77b400 ed71fa80 ed493fd0
> ed6f5a20 ed6a4570 bf1b31a7
> [ 1278.704586] 9da0: ed723590 c20086c8 e58dfdd8 e6059e58 c1bacbec
> c20086c8 c05f97fc e58dfdd8
> [ 1278.708401] 9dc0: e6059e04 e6059dd0 c05fd8c8 c05fd28c e6059dd0
> e6059dd0 e6059dd8 e6059dd8
> [ 1278.712208] 9de0: 00000000 bf1b31a7 e58dfc68 e6059e58 e58dfdd8
> ffffffff e6059e14 e6059e08
> [ 1278.716078] 9e00: c06f2514 c05fd870 e6059e54 e6059e18 c05fe524
> c06f2508 e6059e54 e6059e28
> [ 1278.719910] 9e20: c06da1ac c1410518 c141015c bf1b31a7 c20086c8
> e58dfc68 ffffffff 7fffffff
> [ 1278.723755] 9e40: 00000000 00000000 e6059ecc e6059e58 c05f1570
> c05fe4d4 7ffffffe 00000000
> [ 1278.727581] 9e60: 00000000 00000000 ffffffff 7fffffff 00000001
> 00000000 00000000 00000000
> [ 1278.731409] 9e80: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 bf1b31a7
> [ 1278.735228] 9ea0: e6059f34 ffffffff e58dfdd8 e676d7c0 7fffffff
> 00000000 00000000 00000076
> [ 1278.739109] 9ec0: e6059f04 e6059ed0 c05f2cac c05f1480 ffffffff
> 7fffffff 00000001 00000000
> [ 1278.742970] 9ee0: e676d7c8 ffffffff 7fffffff e58dfc68 c04011c4
> e6058000 e6059f2c e6059f08
> [ 1278.746848] 9f00: c06f1f20 c05f2c58 ffffffff 7fffffff e676d7c0
> e676d7c0 00000000 ffffffff
> [ 1278.750806] 9f20: e6059f64 e6059f30 c06e437c c06f1f00 ffffffff
> 7fffffff 00000000 00000000
> [ 1278.754698] 9f40: c06c6a98 c06c59dc e676d7c0 e676d7c0 00000000
> 00000076 e6059f94 e6059f68
> [ 1278.758553] 9f60: c06e4444 c06e433c ffffffff 7fffffff 00000000
> c0401100 e6059fac 0003b8f0
> [ 1278.762465] 9f80: 0003b7e8 00000000 e6059fa4 e6059f98 c06e4764
> c06e4404 00000000 e6059fa8
> [ 1278.766315] 9fa0: c0401000 c06e4754 0003b8f0 0003b7e8 00000005
> 00046a80 00000064 00000000
> [ 1278.770146] 9fc0: 0003b8f0 0003b7e8 00000000 00000076 00000000
> bea318f8 bea318e8 bea318f0
> [ 1278.773976] 9fe0: b6da85ec bea31898 b6eea0d0 b6da8614 600d0010
> 00000005 00000000 00000000
> [ 1278.777818] Backtrace:
> [ 1278.779056] [<c0696790>] (zs_map_object) from [<bf0bad70>]
> (zram_bvec_rw.constprop.2+0x3d8/0xa34 [zram])
> [ 1278.783562]  r10:e544f000 r9:c20086c8 r8:e5713680 r7:e544f000
> r6:00000008 r5:d89c2000
> [ 1278.787300]  r4:e64bf400
> [ 1278.788619] [<bf0ba998>] (zram_bvec_rw.constprop.2 [zram]) from
> [<bf0bb56c>] (zram_make_request+0x1a0/0x494 [zram])
> [ 1278.793537]  r10:00001000 r9:e64bf400 r8:e182d840 r7:00001000
> r6:00000001 r5:00001000
> [ 1278.797252]  r4:00000000
> [ 1278.798512] [<bf0bb3cc>] (zram_make_request [zram]) from
> [<c091fc7c>] (generic_make_request+0x118/0x408)
> [ 1278.803535]  r10:c21db2a0 r9:ffffffff r8:c2043828 r7:00000000
> r6:e182d840 r5:ffffe000
> [ 1278.807294]  r4:e55e8000
> [ 1278.808572] [<c091fb64>] (generic_make_request) from [<c091ffc0>]
> (submit_bio+0x54/0x1c4)
> [ 1278.812454]  r10:e58dfc68 r9:00000000 r8:00000008 r7:00000800
> r6:00000801 r5:e182d840
> [ 1278.816137]  r4:c20086c8
> [ 1278.817417] [<c091ff6c>] (submit_bio) from [<c06ee354>]
> (submit_bh_wbc+0x19c/0x1cc)
> [ 1278.821098]  r10:e58dfc68 r9:00000000 r8:00000000 r7:00000800
> r6:00000801 r5:e182d840
> [ 1278.824858]  r4:e5a88580
> [ 1278.826122] [<c06ee1b8>] (submit_bh_wbc) from [<c06ee700>]
> (__block_write_full_page+0x37c/0x6f0)
> [ 1278.830284]  r9:00000000 r8:00000800 r7:e6059e58 r6:e5a88580
> r5:e5a88580 r4:00000001
> [ 1278.833968] [<c06ee384>] (__block_write_full_page) from
> [<c06eeda0>] (block_write_full_page+0x190/0x198)
> [ 1278.838448]  r10:00000000 r9:00000001 r8:c06f2564 r7:e58dfd0c
> r6:600d0013 r5:ed496460
> [ 1278.842157]  r4:e58dfc68
> [ 1278.843410] [<c06eec10>] (block_write_full_page) from [<c06f2564>]
> (blkdev_writepage+0x24/0x28)
> [ 1278.847528]  r10:e58dfdd8 r9:e6059e58 r8:00000001 r7:e6059d5c
> r6:c1b9e48c r5:00000002
> [ 1278.851241]  r4:e58dfdd8
> [ 1278.852509] [<c06f2540>] (blkdev_writepage) from [<c05f9820>]
> (__writepage+0x24/0x5c)
> [ 1278.856201] [<c05f97fc>] (__writepage) from [<c05fd4bc>]
> (write_cache_pages+0x23c/0x5e4)
> [ 1278.860010]  r5:00000002 r4:ed496460
> [ 1278.861756] [<c05fd280>] (write_cache_pages) from [<c05fd8c8>]
> (generic_writepages+0x64/0x90)
> [ 1278.865824]  r10:e58dfdd8 r9:c05f97fc r8:c20086c8 r7:c1bacbec
> r6:e6059e58 r5:e58dfdd8
> [ 1278.869552]  r4:c20086c8
> [ 1278.870805] [<c05fd864>] (generic_writepages) from [<c06f2514>]
> (blkdev_writepages+0x18/0x1c)
> [ 1278.874871]  r6:ffffffff r5:e58dfdd8 r4:e6059e58
> [ 1278.877398] [<c06f24fc>] (blkdev_writepages) from [<c05fe524>]
> (do_writepages+0x5c/0x108)
> [ 1278.881292] [<c05fe4c8>] (do_writepages) from [<c05f1570>]
> (__filemap_fdatawrite_range+0xfc/0x128)
> [ 1278.885538]  r9:00000000 r8:00000000 r7:7fffffff r6:ffffffff
> r5:e58dfc68 r4:c20086c8
> [ 1278.889480] [<c05f1474>] (__filemap_fdatawrite_range) from
> [<c05f2cac>] (file_write_and_wait_range+0x60/0xb4)
> [ 1278.894166]  r10:00000076 r9:00000000 r8:00000000 r7:7fffffff
> r6:e676d7c0 r5:e58dfdd8
> [ 1278.897979]  r4:ffffffff
> [ 1278.899227] [<c05f2c4c>] (file_write_and_wait_range) from
> [<c06f1f20>] (blkdev_fsync+0x2c/0x58)
> [ 1278.903348]  r9:e6058000 r8:c04011c4 r6:e58dfc68 r5:7fffffff r4:ffffffff
> [ 1278.906618] [<c06f1ef4>] (blkdev_fsync) from [<c06e437c>]
> (vfs_fsync_range+0x4c/0x8c)
> [ 1278.910366]  r6:ffffffff r5:00000000 r4:e676d7c0
> [ 1278.912646] [<c06e4330>] (vfs_fsync_range) from [<c06e4444>]
> (do_fsync+0x4c/0x74)
> [ 1278.916241]  r7:00000076 r6:00000000 r5:e676d7c0 r4:e676d7c0
> [ 1278.918974] [<c06e43f8>] (do_fsync) from [<c06e4764>] (sys_fsync+0x1c/0x20)
> [ 1278.922350]  r6:00000000 r5:0003b7e8 r4:0003b8f0
> [ 1278.924675] [<c06e4748>] (sys_fsync) from [<c0401000>]
> (ret_fast_syscall+0x0/0x28)
> [ 1278.928344] Exception stack(0xe6059fa8 to 0xe6059ff0)
> [ 1278.930781] 9fa0:                   0003b8f0 0003b7e8 00000005
> 00046a80 00000064 00000000
> [ 1278.934719] 9fc0: 0003b8f0 0003b7e8 00000000 00000076 00000000
> bea318f8 bea318e8 bea318f0
> [ 1278.938627] 9fe0: b6da85ec bea31898 b6eea0d0 b6da8614
> [ 1278.941101] Code: e5927000 e0060391 e0873006 e5938018 (e5982000)
> [ 1278.944270] ---[ end trace 2de575b2ace669f8 ]---
> [ 1278.947457] note: mkfs.ext4[11598] exited with preempt_count 2
> 
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/1350791#L15827
> https://lkft.validation.linaro.org/scheduler/job/1351118#L15840
> https://lkft.validation.linaro.org/scheduler/job/1350630#L16995

Since I couldn't find culprit patch, I tried to reproduce it in
my QEMU x86 testing box but couldn't.

$ make -C tools/testing/selftests TARGETS=zram run_tests

What was your kernel config? Ram size? the number of CPU?

It's the only testcase you were running? Or there are background
jobs in parallel? The symptom could happen if memory is corrupted
by others.

When I see the log, it seems you could produce very soon.
What was good kerenl you have seen last time?
It would be very helpful if you Could bisect it.

Thanks.
