Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243716E681C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDRPai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDRPaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 11:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66702E71
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Apr 2023 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681831742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xy2baqViLPQFaV+ePofs2RF21rT4D1RwTBQ+hV2mFL0=;
        b=USrxZzoio94HayaYP5cNGQ/7gKvog+lIgI25NjUiJwNb37EeJDAOMINxjocwcsoq+TPvDg
        zWI5t+PDwK+vfTMO2aiWNg1FOZaLIYd9ejhK0CL+gKyMhiNKrKVSXqy9JjYtfYkHZg+YrG
        hp4CUIWKtec+sG/OVYFzyqOJSVcM5mk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-1Y5Vri3MOPCaoatnNYVwXg-1; Tue, 18 Apr 2023 11:28:56 -0400
X-MC-Unique: 1Y5Vri3MOPCaoatnNYVwXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12B78889059;
        Tue, 18 Apr 2023 15:28:54 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7EB914152F6;
        Tue, 18 Apr 2023 15:28:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 0/3] mm/ksm: improve PR_SET_MEMORY_MERGE=0 handling and cleanup disabling KSM
Date:   Tue, 18 Apr 2023 17:28:46 +0200
Message-Id: <20230418152849.505124-1-david@redhat.com>
In-Reply-To: <20230418051342.1919757-1-shr@devkernel.io>
References: <20230418051342.1919757-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a follow-up to [1]:
	[PATCH v9 0/3] mm: process/cgroup ksm support

which is not in mm-unstable yet (but soon? :) ). I'll be on vacation for
~2 weeks, so sending it out now as reply to [1].

(1) Make PR_SET_MEMORY_MERGE=0 unmerge pages like setting MADV_UNMERGEABLE
does, (2) add a selftest for it and (3) factor out disabling of KSM from
s390/gmap code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>

[1] https://lkml.kernel.org/r/20230418051342.1919757-1-shr@devkernel.io

David Hildenbrand (3):
  mm/ksm: unmerge and clear VM_MERGEABLE when setting
    PR_SET_MEMORY_MERGE=0
  selftests/ksm: ksm_functional_tests: add prctl unmerge test
  mm/ksm: move disabling KSM from s390/gmap code to KSM code

 arch/s390/mm/gmap.c                           | 20 +------
 include/linux/ksm.h                           |  7 +++
 kernel/sys.c                                  |  7 +--
 mm/ksm.c                                      | 58 +++++++++++++++++++
 .../selftests/mm/ksm_functional_tests.c       | 46 +++++++++++++--
 5 files changed, 107 insertions(+), 31 deletions(-)

-- 
2.39.2

