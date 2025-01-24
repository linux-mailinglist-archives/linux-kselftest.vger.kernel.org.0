Return-Path: <linux-kselftest+bounces-25062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EEEA1AE5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 02:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4322916CB00
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 01:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD61D79B6;
	Fri, 24 Jan 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tQNRiiBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3481D6DCC
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683936; cv=none; b=cwk7kIH9zqujwmRkiibHbP5Mnlu+xkatnxUIA0hVzm2cxGjXIyNrIa05ioBFA4tFMXIyqcshxV0L+FSNxuOoqyv+lTXBae3KFikHseVGNYzs+2BnVfLQ4c1z77+ghD/WBkLbu29aQ7r7qTbKjXpMhiq+cZSYdnKaDzB2XG6lt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683936; c=relaxed/simple;
	bh=14hdZvQy12znP3JBrDTEin8Vq/JMaX7z3pC3iDZMCHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANxLKWMpzzr8mQ3wh0zMaw5rk1NeKS5fZm5udq40h4GSi5zN7+Ijfwgaw6ygDDVugRyHL0PFnoWmpLtt51PgHFmaLRrkmtWRau/SZid6UiCxB61xDTjAPR8FRS1l/7r9fzQFJ4txAmcKpdnOuvEIIikti8czewp1oN1kLzk6Akc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=tQNRiiBI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so129823085a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 17:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683933; x=1738288733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZvohp5XISf/Tn/4fv46H+WUbuRmv7JS7QX/Rz1OCJ8=;
        b=tQNRiiBI6/h6TBEY0YQL5rHaeScChu6j8UCh5D7jCO2dMa5kzHTHuYzC0Ms92qJRgn
         wyho/uHXGO7ZVOoQMLLoDWtLzCMPEndXMBRKwcvVlTShI9pZEbb+21LcV6xNqcTdN0VX
         kV0HVpY14gOsBbYd6mcxoM3x98EnCt0xx9IK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683933; x=1738288733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZvohp5XISf/Tn/4fv46H+WUbuRmv7JS7QX/Rz1OCJ8=;
        b=YiWFc8iDVH3Va4hOsmw4Ht8wk9nh8vitKzYMemTs2BsQnfB+Y0KZp9A0ehh+ASbjn9
         h9cw7Iz271I/UabcmM3uU9YIB1slVH/+7vdx6kvbAz37zP2QpZMfYx9/aGEoF8K6nuU6
         1k9P0lOuHJdoJdWkvmuBelCfxbzZCpRQ1RwjXEi8vE0azLZTeKoCRYQs835cDBVWD3LF
         mFs1gQB5scPGngyFc35i/EDR0P9AgDGdqXQEZp1fVMcFsRiFh6+EY0OtdOZR9KTuMS+x
         BaMAdl9kjys0FRpVHl3h685B9PumVbVenwbcpd/oy7GA9iAo5vdH6BH4zR3rE3YDAZVV
         ZXSg==
X-Forwarded-Encrypted: i=1; AJvYcCW7VvoSpXaSqIicNyQhgTtQHgjhx+lCA6j0pUG43KzuUXipNeLdmiB5KmElqLeltFGC8lqpKLJQl+/uh08PrKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsAASEX3xNt4MNraXLjd2osZ5hX26zy7V8dF0g7Xm7sfERLF3
	rS79SGGTNIe8zLh3FrC7h/8duA9sggAQ8TiiXw4oK/ut1XJyKJVuUef6NRopymw=
X-Gm-Gg: ASbGncutNJEq3cRxQ0UT+f2j8CG9PX2kyBv8YQ1dmzqr5C/6GmTMZkj8jyaUSxhN8Rt
	WH5+Yt849eckd9Bq/kANAyYIaTo/lIpulihIiWcludPU0avznLf8T3NXtF6ZHdGrok46YrQ/2k4
	41HRm92oUi7kkrOaPTbUIz1kju6uZzqzTfRmq5Cuun9Er05ERkPO9Mo8DtYlwO8jVAxLPeOMXjO
	wMRlRU6u8/WwPFFKwhN63JB9BQpwmeLcJ391QB51/s5ifCRLaf5vfqv57cj2BPsEfNSAsw52+/K
	wsWpH0IxY7fKKx9jtrsjEm7+asllYm/8ibiwogoK66gW8o4=
X-Google-Smtp-Source: AGHT+IEkcvw4t/4hDB4cpARpmSXHhl01930tx115y0v5Ooc1uQWUDLkSS1M1ktdAujYLyLZ2bXnA1A==
X-Received: by 2002:a05:620a:2a0a:b0:7b8:5520:1888 with SMTP id af79cd13be357-7be6328a7d5mr4527305185a.57.1737683933360;
        Thu, 23 Jan 2025 17:58:53 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a5fbsm44741985a.31.2025.01.23.17.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:58:52 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 4/5] rcutorture: mkinitrd: Use previous init.c to check if rebuild needed
Date: Thu, 23 Jan 2025 20:58:35 -0500
Message-Id: <20250124015836.732086-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124015836.732086-1-joel@joelfernandes.org>
References: <20250124015836.732086-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create the init.c as a temporary init-tmp.c file, even if init already
exists.  Ensure the existing init.c matches this. If init.c doesn't
exist in initrd/ then skip the check and assume init-tmp.c as the new
init.c.  After that, check if init binary already exists as we did
before and skip the build if it does.

This does mean we keep a copy of init.c around in the initrd but this is
a small file and it is useful to see for debugging anyway.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../selftests/rcutorture/bin/mkinitrd.sh      | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 4ba5e962e3cf..d9fbfa205384 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -17,10 +17,6 @@ if [ ! -d "$D" ]; then
     echo >&2 "$D does not exist: Malformed kernel source tree?"
     exit 1
 fi
-if [ -s "$D/initrd/init" ]; then
-    echo "$D/initrd/init already exists, no need to create it"
-    exit 0
-fi
 
 # Create a C-language initrd/init infinite-loop program and statically
 # link it.  This results in a very small initrd.
@@ -29,8 +25,10 @@ cd $D
 mkdir -p initrd
 cd initrd
 
-# Generate the init.c with optional command
-cat > init.c << 'EOF_HEAD'
+# Generate an init-tmp.c with optional command. This will then be compared
+# with any existing init.c. The reason for this is, we want to force a
+# rebuild if the optional command or command line arguments have changed.
+cat > init-tmp.c << 'EOF_HEAD'
 #ifndef NOLIBC
 #include <unistd.h>
 #include <sys/time.h>
@@ -45,7 +43,7 @@ if [ $# -gt 0 ]; then
     # If command provided, generate run_optional_command() with the specified command.
     # We use printf to generate the command and args.
     # Example: echo $(printf '"%s", ' cmd a1 a2) gives: "cmd", "a1", "a2",
-    cat >> init.c << EOF
+    cat >> init-tmp.c << EOF
     pid_t pid = fork();
     if (pid == 0) {
         char *args[] = {$(printf '"%s", ' "$@")NULL};
@@ -54,11 +52,11 @@ if [ $# -gt 0 ]; then
 EOF
 else
     # If no command provided, function will be empty
-    echo "    /* No command specified */" >> init.c
+    echo "    /* No command specified */" >> init-tmp.c
 fi
 
 # Add the rest of the program
-cat >> init.c << 'EOF_TAIL'
+cat >> init-tmp.c << 'EOF_TAIL'
 }
 
 int main(int argc, char *argv[])
@@ -95,6 +93,23 @@ int main(int argc, char *argv[])
 }
 EOF_TAIL
 
+# Check if init.c exists and compare with init-tmp.c
+if [ -f "init.c" ]; then
+    if ! cmp -s "init.c" "init-tmp.c"; then
+        mv "init-tmp.c" "init.c"
+    else
+        rm "init-tmp.c"
+    fi
+else
+    mv "init-tmp.c" "init.c"
+fi
+
+# Now check if init binary exists and is up to date
+if [ -s "init" ] && [ "init" -nt "init.c" ]; then
+    echo "$D/initrd/init already exists and is up to date"
+    exit 0
+fi
+
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
 if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
@@ -120,7 +135,6 @@ then
 	exit "$ret"
 fi
 
-rm init.c
 echo "Done creating a statically linked C-language initrd"
 
 exit 0
-- 
2.34.1


