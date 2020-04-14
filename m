Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF31A8CB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633319AbgDNUmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 16:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633316AbgDNUmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 16:42:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B4EC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 13:42:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id 2so922850plb.20
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2I4WctQI04EdVNnfO5lBoNqQ0BOagrVFsoryQp+bCLA=;
        b=L6GM5cBJqkKVg5zJHTT3FNf5PifBt04sqQpo6G+cq90o8x9xVr9Zmhkf7uJMX6SA8l
         C4oDGWtZ6a4Xt52qk9koWnkHKLhZXLh/CrxmKzWMMRN/BPDrTzweb2634OSKWci8MzbT
         e5Te+HFfxMc5Qc3FVrCso5I1UKg/TUFv8LZysVg7D7Q7ozxQIuetn42l8vwgCezfuA8W
         l42PmfDaeD+RWBh3pzpMpzfXeTDXRHWhossBAGJlq2/vHyiHIny2+STqv7glSmF9f+4B
         nW4uCxMQWyQa+1yeSY2zYhj1faxNF3ckLdMnF8DXPzcDWVsYmLk3AgMDjG60L7jACpEt
         k+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2I4WctQI04EdVNnfO5lBoNqQ0BOagrVFsoryQp+bCLA=;
        b=bgPqV4GIlzNDGZyCau4ugiSW5mMYSPhp+NC65SVoH1pqAb6hOvLX1FPSY3G/Lz5mS3
         m4QLDjJnJ5AFdKavinopgp6WDSCkX7hkSn2Bs06NPqhQ39jG7t4XQ4YRZW8GNZRFrrYl
         eOfm1z0/9qKZHMNX1APf/hCRFmJsrcT2i4XCPjxHn07oLlUOqu0JjpK/jyEILnamjAw1
         CsXFBBaY56RKsS0lo5tX0JxwM5ylPWUJ+gQvJ4jtmNrqWMt7ylhwsn6C0VZyHC73L8cD
         k5LCOAnxJ6xqUa6EE0zY278ayxxsv65Y24e26UkMcZ+P4JcuHLQlMuAhoEfUad46fbFD
         lEig==
X-Gm-Message-State: AGi0PubiVgSZ+u0d23pJR+wjOCJ3e+eu42tGNdF3XBd83Ela2Qg1JpIo
        NMWxHnqLpwdnCEugXAatJ/mKCzf4EVXqNy5s0ST4tw==
X-Google-Smtp-Source: APiQypJzWAJm5j7iwmdejE8yFesxbFduUzJRhz3WDXDmtbZpHCJ0E8FSgVtgYRMEJWgRaApGIHBybA+XIbEp/X+jPyRY3g==
X-Received: by 2002:a17:90a:be18:: with SMTP id a24mr2099925pjs.92.1586896964526;
 Tue, 14 Apr 2020 13:42:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:42:40 -0700
Message-Id: <20200414204240.186377-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v1] kobject: make sure parent is not released before children
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        sakari.ailus@linux.intel.com, andy.shevchenko@gmail.com,
        hdegoede@redhat.com, rafael.j.wysocki@intel.com,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        shuah@kernel.org, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org, linux@rasmusvillemoes.dk,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Previously, kobjects were released before the associated kobj_types;
this can cause a kobject deallocation to fail when the kobject has
children; an example of this is in software_node_unregister_nodes(); it
calls release on the parent before children meaning that children can be
released after the parent, which may be needed for removal.

So, take a reference to the parent before we delete a node to ensure
that the parent is not released before the children.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
Link: https://lore.kernel.org/linux-kselftest/CAFd5g44s5NQvT8TG_x4rwbqoa7zWzkV0TX+ETZoQdOB7OwXCPQ@mail.gmail.com/T/#m71f37f3985f2abd7209c8ca8e0fa4edc45e171d6
Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

This patch is based on the diff written by Heikki linked above.

Heikki, can you either reply with a Signed-off-by? Otherwise, I can
resend with me as the author and I will list you as the Co-developed-by.

Sorry for all the CCs: I just want to make sure everyone who was a party
to the original bug sees this.

---
 lib/kobject.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 83198cb37d8d..5921e2470b46 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
  */
 static void kobject_cleanup(struct kobject *kobj)
 {
+	struct kobject *parent = kobj->parent;
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
@@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
 		kobject_uevent(kobj, KOBJ_REMOVE);
 	}
 
+	/* make sure the parent is not released before the (last) child */
+	kobject_get(parent);
+
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
@@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
 		t->release(kobj);
 	}
 
+	kobject_put(parent);
+
 	/* free name if we allocated it */
 	if (name) {
 		pr_debug("kobject: '%s': free name\n", name);

base-commit: 8632e9b5645bbc2331d21d892b0d6961c1a08429
-- 
2.26.0.110.g2183baf09c-goog

