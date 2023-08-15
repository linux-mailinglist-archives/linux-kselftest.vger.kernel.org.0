Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4214077D30A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjHOTK0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjHOTKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 15:10:16 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039819A4
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 12:09:51 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34992058e95so24307225ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692126590; x=1692731390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNj070RLyTuUaPJVeAHJLnmbdqPt3qMFEPUjovYEkRk=;
        b=WjYCSrq7A56vtRUVoV7qotEUe5yCSr0QzIEZ3bAmGe/O5gaUvfjR8bxWJNKYKk5w6u
         eS4wVUdSnLnButvaW6a0OWPo3+4QwvAZ2fcOJz3E98sZWCn6W6YSCazIHEKzxOX8rFcI
         gHxyNGLpnCsv7qsYbYFharB7SKFQMPbdTDO2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692126590; x=1692731390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNj070RLyTuUaPJVeAHJLnmbdqPt3qMFEPUjovYEkRk=;
        b=MIQgpkTxx7ylGk5bIq3d4KydP3MCjm17/oJgozT9aZiDTGj2hR/f7jctg5e7uEeXgq
         3C3q2y0taFPCjek/iF+UjG922sltN3OyfmlREfRss6PFdOY8mrXrsMx+Co7hSj3jRBr2
         4KX2f+LgPs1Nm441emMV5T3n55H6ZlmDqraqTjjkPa5vACJkxbXmt3B9XcwC/9+WwrVQ
         O+mlmzx9lXj5kjy5Q2y8+iKRK8aI5u+etAyPxXdMzM9wzbE44FpCH6gM8W7GuW8XjRXn
         Adi8Uuglc6BtJQU5p/0fJBeylLG0CH26UteFmBU1g6OuETavg/DAVfg8xG7bVCSfKYP2
         UMag==
X-Gm-Message-State: AOJu0YzAZuL6Uk6JJ4pO1Y7aK5sBdHWX3fcza7mRouFFZV49/780yytB
        RFfXcFJgAziAw5f2f8ZTB9f09g==
X-Google-Smtp-Source: AGHT+IFpCDY7trQRG6cp/LxmZFhOBcNsdIbyEFSLsLs/Hd3i+vBHfSUhqXC3aM/q1j0Cjrzg8hC/8A==
X-Received: by 2002:a05:6e02:13ef:b0:348:6f4a:c341 with SMTP id w15-20020a056e0213ef00b003486f4ac341mr17372320ilj.25.1692126590710;
        Tue, 15 Aug 2023 12:09:50 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id l7-20020a92d947000000b00345e3a04f2dsm4137010ilq.62.2023.08.15.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:09:49 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:09:49 +0000
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel <agnel.joel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3] rcutorture: Copy out ftrace into its own console file
Message-ID: <20230815190949.GA3207581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When debugging, it can be difficult to quickly find the ftrace dump
within the console log, which in turn makes it difficult to process it
independent of the result of the console output.  This commit therefore
copies the contents of the buffers into its own file to make it easier
to locate and process the ftrace dump. The original ftrace dump is still
available in the console log in cases where it is more convenient to
process it there, for example, when you have a script that processes
console output as well as ftrace-dump data.

Also handle the case of multiple ftrace dumps potentially showing up in the
log. Example for a file like [1], it will extract as [2].

[1]:
foo
foo
Dumping ftrace buffer:
---------------------------------
blah
blah
---------------------------------
more
bar
baz
Dumping ftrace buffer:
---------------------------------
blah2
blah2
---------------------------------
bleh
bleh

[2]:

Ftrace dump 1:
blah
blah

Ftrace dump 2:
blah2
blah2


Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
v2->v3: Updates from Paul. Also handle multiple ftrace dumps.

 .../selftests/rcutorture/bin/functions.sh     | 24 +++++++++++++++++++
 .../selftests/rcutorture/bin/parse-console.sh |  7 ++++++
 2 files changed, 31 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..a5c74e508e41
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,30 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output in the original logs look like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+        awk '
+        /Dumping ftrace buffer:/ {
+        buffer_count++
+        print "Ftrace dump " buffer_count ":"
+        capture = 1
+        next
+    }
+    /---------------------------------/ {
+        if(capture == 1) {
+            capture = 2
+            next
+        } else if(capture == 2) {
+            capture = 0
+            print ""
+        }
+    }
+    capture == 2
+    ' "$1";
+}
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9ab0f6bc172c..e3d2f69ec0fb 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -182,3 +182,10 @@ if ! test -s $file.diags
 then
 	rm -f $file.diags
 fi
+
+# Call extract_ftrace_from_console function, if the output is empty,
+# don't create $file.ftrace. Otherwise output the results to $file.ftrace
+extract_ftrace_from_console $file > $file.ftrace
+if [ ! -s $file.ftrace ]; then
+	rm -f $file.ftrace
+fi
-- 
2.41.0.694.ge786442a9b-goog

