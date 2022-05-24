Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F281532EF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiEXQaP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiEXQaP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 12:30:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16E037BE1;
        Tue, 24 May 2022 09:30:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83F4621A19;
        Tue, 24 May 2022 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653409811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0aOp5yJI56RJ+SoECoGbDOaEZ7yLii4c891MVbbA4to=;
        b=vWivk4oDuWVezANW9v3pF+X1FQpt89ke1A10GKiVNLMUJ+jKgPPHySGQopTrxU0imeKFLr
        k+1ZR6j/nCl9XEAgMYfAPpUpabKowr0uyuLmMwXw0sARrEEeOtbpG4gcmjsoNanvdpJ34L
        3mSGJgG0AgCIjZnsfZVZLvG7LV9vDyg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 435A913ADF;
        Tue, 24 May 2022 16:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y49RDxMIjWJaWgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 24 May 2022 16:30:11 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v3 0/5] memcontrol selftests fixups
Date:   Tue, 24 May 2022 18:29:50 +0200
Message-Id: <20220524162955.8635-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello.

I'm just flushing the patches to make memcontrol selftests check the
events behavior we had consensus about (test_memcg_low fails).

(test_memcg_reclaim, test_memcg_swap_max fail for me now but it's present
even before the refactoring.)

The two bigger changes are:
- adjustment of the protected values to make tests succeed with the given
  tolerance,
- both test_memcg_low and test_memcg_min check protection of memory in
  populated cgroups (actually as per Documentation/admin-guide/cgroup-v2.rst
  memory.min should not apply to empty cgroups, which is not the case
  currently. Therefore I unified tests with the populated case in order to to
  bring more broken tests).

Thanks,
Michal

Changes from v2 (https://lore.kernel.org/r/20220518161859.21565-2-mkoutny@suse.com/)
- rebased on mm-stable 02e34fff195d3a5f67cbb553795dc109a37d1dcf
- collected acked-bys
- proper Fixes: tag

Changes from v1 (https://lore.kernel.org/r/20220513171811.730-1-mkoutny@suse.com/)
- fixed mis-rebase in compilation fix patch,
- added review, ack tags from v1,
- applied feedback from v1 (Octave script in git tree),
- added one more patch extracting common parts,
- rebased on mm-stable bbe832b9db2e.

Michal Koutný (5):
  selftests: memcg: Fix compilation
  selftests: memcg: Expect no low events in unprotected sibling
  selftests: memcg: Adjust expected reclaim values of protected cgroups
  selftests: memcg: Remove protection from top level memcg
  selftests: memcg: Factor out common parts of memory.{low,min} tests

 MAINTAINERS                                   |   1 +
 .../selftests/cgroup/memcg_protection.m       |  89 +++++++
 .../selftests/cgroup/test_memcontrol.c        | 247 +++++-------------
 3 files changed, 152 insertions(+), 185 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_protection.m

-- 
2.35.3

