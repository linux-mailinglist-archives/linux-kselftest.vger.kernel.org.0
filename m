Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2179361FE5C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiKGTMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 14:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiKGTMA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 14:12:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDF12A240;
        Mon,  7 Nov 2022 11:11:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B34422534;
        Mon,  7 Nov 2022 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667848318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDZ+1J9gbkdeI4Dq1QHKthecD/b0UCy0MKie46ulwZw=;
        b=oIErcstqUTvnyCIaNr2MynlO/sInNGy8OeQRYWuUtmsni2xUSucAsaolcL0hxrbvpQmM9r
        HGZjGTkEKIX5bRip51TQwuVWmU8pMqM2erjJmzZ/NRaIM5G1ybKD++4VV4PFkuiok+v94n
        5+8+rYslVbI7gX2sF8n6LY+eXjTUNE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667848318;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDZ+1J9gbkdeI4Dq1QHKthecD/b0UCy0MKie46ulwZw=;
        b=MvgZMh0mSA1s7DaPqJILE+epydRvG7/9BFn/TNq6Q2lSPtGgzuoZK1SshRKp231AyPCcTw
        GaGcrGxbHU7jkFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7D2A13AC7;
        Mon,  7 Nov 2022 19:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sLg8I31YaWMjJgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 19:11:57 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 1/1] zram01.sh: Workaround division by 0 on vfat on ppc64le
Date:   Mon,  7 Nov 2022 20:11:36 +0100
Message-Id: <20221107191136.18048-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107191136.18048-1-pvorel@suse.cz>
References: <20221107191136.18048-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Repeatedly read /sys/block/zram*/mm_stat for 1 sec. This should fix bug
on ppc64le on stable kernels, where mem_used_total is often 0.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 58d233f91..76a8ccab4 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -105,6 +105,26 @@ zram_mount()
 	tst_res TPASS "mount of zram device(s) succeeded"
 }
 
+read_mem_used_total()
+{
+	echo $(awk '{print $3}' $1)
+}
+
+# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
+loop_read_mem_used_total()
+{
+	local file="$1"
+	local mem_used_total
+
+	tst_res TINFO "$file"
+	cat $file >&2
+
+	mem_used_total=$(read_mem_used_total $file)
+	[ "$mem_used_total" -eq 0 ] && return 1
+
+	return 0
+}
+
 zram_fill_fs()
 {
 	local mem_used_total
@@ -133,9 +153,12 @@ zram_fill_fs()
 			continue
 		fi
 
-		mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		TST_RETRY_FUNC "loop_read_mem_used_total /sys/block/zram$i/mm_stat" 0
+		mem_used_total=$(read_mem_used_total /sys/block/zram$i/mm_stat)
+		tst_res TINFO "mem_used_total: $mem_used_total"
+
 		v=$((100 * 1024 * $b / $mem_used_total))
-		r=`echo "scale=2; $v / 100 " | bc`
+		r=$(echo "scale=2; $v / 100 " | bc)
 
 		if [ "$v" -lt 100 ]; then
 			tst_res TFAIL "compression ratio: $r:1"
-- 
2.38.0

