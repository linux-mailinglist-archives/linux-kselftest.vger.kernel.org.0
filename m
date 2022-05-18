Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27C52BF9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiERPkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiERPkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:40:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B32CE11;
        Wed, 18 May 2022 08:40:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26C1121B7D;
        Wed, 18 May 2022 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652888447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lUuJK4eL9+OrReBYOWwXyTY//4zqDis40btPse6/uis=;
        b=FI5Sy3NWkxOrgF+oYW8rHSuu2CTrRYidOfq7exPfxbLF4Qkrsd1N8W/xnoeEyD2pIq03Iy
        75Y0dEF6IU3IyPEy/u1XmdxrAQybITgPqa3eVA2Lle1Xs6B5mJzje0n5/56J+/t1UioIh1
        oIKfIkBBwT/U06IqQASwRYrKecBO6jQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAB0413A6D;
        Wed, 18 May 2022 15:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w3xROH4ThWJDUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 15:40:46 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 0/4] memcontrol selftests fixups
Date:   Wed, 18 May 2022 17:40:33 +0200
Message-Id: <20220518154037.18819-1-mkoutny@suse.com>
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

I'm just flushing the simple patches to make memcontrol selftests check the
events behavior we had consensus about (test_memcg_low fails). (I've dropped to
goto macros for now.)

(test_memcg_reclaim, test_memcg_swap_max fail for me now but it's present
even before the refactoring.)

The only bigger change is adjustment of the protected values to make tests
succeed with the given tolerance.

It's based on mm-stable [1] commit e240ac52f7da. AFAIC, the fixup and partial
reverts may be folded into respective commits.
Let me know if it should be (re)based on something else.

Thanks,
Michal

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/tools/testing/selftests/cgroup?h=mm-stable

Michal Koutný (4):
  selftests: memcg: Fix compilation
  selftests: memcg: Expect no low events in unprotected sibling
  selftests: memcg: Adjust expected reclaim values of protected cgroups
  selftests: memcg: Remove protection from top level memcg

 .../selftests/cgroup/test_memcontrol.c        | 59 +++++++++----------
 1 file changed, 29 insertions(+), 30 deletions(-)

-- 
2.35.3

