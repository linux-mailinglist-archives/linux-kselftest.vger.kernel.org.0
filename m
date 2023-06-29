Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A0742EF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 22:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjF2Uvv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 16:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF2Uu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 16:50:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D93B35B7
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 13:50:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c38c87ea9ceso1716875276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688071857; x=1690663857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLzMk6njG0VUm6oo8ECi7NNqjOvlkj+YcLB9LCE7+MA=;
        b=vd6FO9RKLDqV//QD3xfOnLM9ABYCd6dUPJXpRHT4NX5noS8/sUBwSo898iH3nVkB0i
         DtNAyV+Pi6bgq0S9jGXWkBhQ9/YdQKbSPEohpFeN8NdUWPbX25v+l+vYnpTa7r6jcPht
         dbVhBKQwNHFgV1WouNWGszv4XwOpqInDK4ouCSz6Ak/7s9gGDRqjeI3/ZhamBO61VWCa
         Z6gPSDN+iIv39tWkyOgXo6urQM1zLyzmqO53tLfzCPB+LOgT197q6GD2uuEhk9CDZuub
         vqBRd9kZ1XKyBS+VrCDyZJ59YXT8sSu0AY+uPtiN0Du5fb03DdmO0Rm9zeWUxhbXnaCv
         j0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071857; x=1690663857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLzMk6njG0VUm6oo8ECi7NNqjOvlkj+YcLB9LCE7+MA=;
        b=EjRW7QN5LiOfVovR1zQsPzCo/kTYXFzrdj+NaiZTsv6gW6YKs51f/MMr9hX/ocSFge
         MYeh9qsnccsXMWPTGrtT4M3MJ6OrTdSpdjstFIO0BSIirI57LZ335GtcAl+qHMcub00A
         CY4ci5zCg4W87tQP9r3zsDnIWnyHVtwr+2exfa2IB8ruKq0wC+iswJlfj+TeV/VUtfgA
         TFAMZrsGkreolgRQ4ofbZdNM+oS4tksIs9Q8Dy25hmqM4fUfighij3WIFamjlJqYAZVw
         7NZP7aWf3oeCEwfNmHeqkyhW4Mg+kK2N2T0YpLvjo24l4Q+SVgGvMjb0Zx1bvOwYnX/g
         zUCA==
X-Gm-Message-State: ABy/qLaWvTeU2DbzHNRmQxpjp9g8IL1I+FvSbDtqC4S2sIOKZsM1dT8z
        DJlwIYEX9q3Ey6+zAWV4cAElQT405WaVj79Qk6Bq
X-Google-Smtp-Source: APBJJlFxXqx6n/8cIVb44SOqXuMVe8nfJc8KbVSjzubcNqQNTjaVwvxr+Cfitw1Wlj4qp7VAwfdaVDGWjSlIa4+NsAGc
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:e20f:5917:3efa:d4bb])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:1105:b0:bc3:cdb7:4ec8 with
 SMTP id o5-20020a056902110500b00bc3cdb74ec8mr74829ybu.6.1688071857157; Thu,
 29 Jun 2023 13:50:57 -0700 (PDT)
Date:   Thu, 29 Jun 2023 13:50:40 -0700
In-Reply-To: <20230629205040.665834-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629205040.665834-6-axelrasmussen@google.com>
Subject: [PATCH v2 6/6] mm: userfaultfd: add basic documentation for UFFDIO_POISON
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Just describe the feature at a really basic level.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 7c304e432205..b19053436369 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -244,6 +244,21 @@ write-protected (so future writes will also result in a WP fault). These ioctls
 support a mode flag (``UFFDIO_COPY_MODE_WP`` or ``UFFDIO_CONTINUE_MODE_WP``
 respectively) to configure the mapping this way.
 
+Memory Poisioning Emulation
+---------------------------
+
+In response to a fault (either missing or minor), an action userspace can
+take to "resolve" it is to issue a ``UFFDIO_POISON``. This will cause any
+future faulters to either get a SIGBUS, or in KVM's case the guest will
+receive an MCE as if there were hardware memory poisoning.
+
+This is used to emulate hardware memory poisoning. Imagine a VM running on a
+machine which experiences a real hardware memory error. Later, we live migrate
+the VM to another physical machine. Since we want the migration to be
+transparent to the guest, we want that same address range to act as if it was
+still poisoned, even though it's on a new physical host which ostentisbly
+doesn't have a memory error in the exact same spot.
+
 QEMU/KVM
 ========
 
-- 
2.41.0.255.g8b1d071c50-goog

