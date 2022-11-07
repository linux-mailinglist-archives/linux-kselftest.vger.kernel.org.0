Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862AF61FE59
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 20:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiKGTMM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 14:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiKGTL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 14:11:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199029811;
        Mon,  7 Nov 2022 11:11:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92C0F223FD;
        Mon,  7 Nov 2022 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667848317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/62V3PSII9/iNCFnoE48lld+IK4eTx+SC7hHh8nq23o=;
        b=WgtVkftIc2Z3wPesdsvxe6ZknBvfsbSDbMkXt41WvmzyR9nDYcMrmlnsRmlCqVj9XOI6jj
        815iC6cDmRIFJsoh7Ul5KdV5PgV3sMJcMh+ql19V4V/TnNTnt3Tqp4uvrWsf30b6EcpSTV
        cDDpOUup+YflXg3JL5rYUlsLg9EqCjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667848317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/62V3PSII9/iNCFnoE48lld+IK4eTx+SC7hHh8nq23o=;
        b=DUL0MFhVynRThScBibdNyfr+9SEf8qDO6U+7QMRcLQuucFCaRLKlr1Omej/8E0MJk0MgGQ
        Lmwhc/EiygcZGCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 711B013AC7;
        Mon,  7 Nov 2022 19:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PaIuGHxYaWMjJgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 19:11:56 +0000
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
Subject: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Date:   Mon,  7 Nov 2022 20:11:35 +0100
Message-Id: <20221107191136.18048-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
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

Hi all,

following bug is trying to workaround an error on ppc64le, where
zram01.sh LTP test (there is also kernel selftest
tools/testing/selftests/zram/zram01.sh, but LTP test got further
updates) has often mem_used_total 0 although zram is already filled.

Patch tries to repeatedly read /sys/block/zram*/mm_stat for 1 sec,
waiting for mem_used_total > 0. The question if this is expected and
should be workarounded or a bug which should be fixed.

REPRODUCE THE ISSUE
Quickest way to install only zram tests and their dependencies:
make autotools && ./configure && for i in testcases/lib/ testcases/kernel/device-drivers/zram/; do cd $i && make -j$(getconf _NPROCESSORS_ONLN) && make install && cd -; done

Run the test (only on vfat)
PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=vfat zram01.sh

Petr Vorel (1):
  zram01.sh: Workaround division by 0 on vfat on ppc64le

 .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.38.0

