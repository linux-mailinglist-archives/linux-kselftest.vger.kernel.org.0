Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF260DDE95
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2019 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJTNRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Oct 2019 09:17:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfJTNRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Oct 2019 09:17:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so1047633wrs.9;
        Sun, 20 Oct 2019 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBsUqs8jqBvSIFfpE9lf40jZypisanH4mwM2peO1OfA=;
        b=Ui3zDKwE8mZ777YswsWFDM41503cR/Au164MXSpukz7I9tzle0EewBrGeDlCbIWZ6i
         vQGRLB7rFK3sIW/etfrouDUQ+qrHkcDcadtR0ZQ9HzGRaNYnPYJc/4+OyAsM/VOxN+Oc
         HhyA8n7OBsUpzXdHgYIk0lM914nUHAh3gTUE6eY6n7e8HSz0zMXqthiDCNOM64hSIwMW
         IhP15NY/qvRK6hcBXOyVlt4tn9nF9t4D2/6uJhPaSGivQ8i/BX9NCQSWYM3P0jbo9/yd
         o7497MqB6WuUgiaDY67aSfuB69dn85j+JFCyaJ8er33uESicycKqiePQKnGb5URCnKMt
         hpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBsUqs8jqBvSIFfpE9lf40jZypisanH4mwM2peO1OfA=;
        b=eb4+5ibLa0FbFcwks/6ZgY9+wTXUmpTe5QEB5SpV+3DB3ImKKqeeviLRdVaC+ui2b3
         FUoSmtOfBTkT/QZx5ozewTFOX8O9NqP26W4i0TYIZalxQ+2HkqiHlln0Icj4St6CHtQ3
         4I59P4HNbH9/X+L0iVCzzs5jYnoIDTE7RiYsCkjaRdZtCDvG36BZsZutdvXqRtW81lPP
         0qOzSA0R3wcQuaxtd0toZQ2+1qViMsLpEx4dZ3AaFs0Yk+ZmM8rBDZHKzBfOerOW4LWy
         hxM2/m6uVBR//XjQJYqR77Iju1wYcoMYyPvbAAriUV9Gs4CXEE8NpqNW0F87T+c8HHkw
         pSUA==
X-Gm-Message-State: APjAAAXOwT5rIMRn1bgUGzgRHTva6EkWUjxbzRiVVL81un7X+9HbmY4O
        IAe84bpeXSQypRIcfb/XISFg8o8AaZk=
X-Google-Smtp-Source: APXvYqxe9wBz7AvNQplFig0s8Ty42QjBm2sUBHVRMHsK3/4gvqgaFlt4aDECnevElIJZlxJGpTDrIg==
X-Received: by 2002:adf:da42:: with SMTP id r2mr14944541wrl.383.1571577457611;
        Sun, 20 Oct 2019 06:17:37 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id y3sm20177657wro.36.2019.10.20.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 06:17:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        jani.nikula@linux.intel.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'
Date:   Sun, 20 Oct 2019 21:17:17 +0800
Message-Id: <20191020131717.28990-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 'functions' directive is not only for functions, but also works for
structs/unions. So the name is misleading. This patch renames it to
'identifiers', which specific the functions/types to be included in
documentation. We keep the old name as an alias of the new one before
all documentation are updated.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2:
  o use 'identifiers' as the new directive name.
---
 Documentation/doc-guide/kernel-doc.rst | 29 ++++++++++++++------------
 Documentation/sphinx/kerneldoc.py      | 19 ++++++++++-------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 192c36af39e2..fff6604631ea 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -476,6 +476,22 @@ internal: *[source-pattern ...]*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :internal:
 
+identifiers: *[ function/type ...]*
+  Include documentation for each *function* and *type* in *source*.
+  If no *function* is specified, the documentation for all functions
+  and types in the *source* will be included.
+
+  Examples::
+
+    .. kernel-doc:: lib/bitmap.c
+       :identifiers: bitmap_parselist bitmap_parselist_user
+
+    .. kernel-doc:: lib/idr.c
+       :identifiers:
+
+functions: *[ function/type ...]*
+  This is an alias of the 'identifiers' directive and deprecated.
+
 doc: *title*
   Include documentation for the ``DOC:`` paragraph identified by *title* in
   *source*. Spaces are allowed in *title*; do not quote the *title*. The *title*
@@ -488,19 +504,6 @@ doc: *title*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :doc: High Definition Audio over HDMI and Display Port
 
-functions: *[ function ...]*
-  Include documentation for each *function* in *source*.
-  If no *function* is specified, the documentation for all functions
-  and types in the *source* will be included.
-
-  Examples::
-
-    .. kernel-doc:: lib/bitmap.c
-       :functions: bitmap_parselist bitmap_parselist_user
-
-    .. kernel-doc:: lib/idr.c
-       :functions:
-
 Without options, the kernel-doc directive includes all documentation comments
 from the source file.
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 1159405cb920..0689f9c37f1e 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
     optional_arguments = 4
     option_spec = {
         'doc': directives.unchanged_required,
-        'functions': directives.unchanged,
         'export': directives.unchanged,
         'internal': directives.unchanged,
+        'identifiers': directives.unchanged,
+        'functions': directives.unchanged,  # alias of 'identifiers'
     }
     has_content = False
 
@@ -71,6 +72,7 @@ class KernelDocDirective(Directive):
 
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
+        identifiers = None
 
         # Tell sphinx of the dependency
         env.note_dependency(os.path.abspath(filename))
@@ -86,19 +88,22 @@ class KernelDocDirective(Directive):
             export_file_patterns = str(self.options.get('internal')).split()
         elif 'doc' in self.options:
             cmd += ['-function', str(self.options.get('doc'))]
+        elif 'identifiers' in self.options:
+            identifiers = self.options.get('identifiers').split()
         elif 'functions' in self.options:
-            functions = self.options.get('functions').split()
-            if functions:
-                for f in functions:
-                    cmd += ['-function', f]
-            else:
-                cmd += ['-no-doc-sections']
+            identifiers = self.options.get('functions').split()
 
         for pattern in export_file_patterns:
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
                 env.note_dependency(os.path.abspath(f))
                 cmd += ['-export-file', f]
 
+        if identifiers:
+            for i in identifiers:
+                cmd += ['-function', i]
+        elif identifiers is not None:
+            cmd += ['-no-doc-sections']
+
         cmd += [filename]
 
         try:
-- 
2.20.1

