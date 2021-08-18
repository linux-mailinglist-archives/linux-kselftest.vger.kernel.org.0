Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F077C3F0856
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbhHRPsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 11:48:04 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46828 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhHRPry (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 11:47:54 -0400
Received: by mail-lf1-f46.google.com with SMTP id u22so5519459lfq.13;
        Wed, 18 Aug 2021 08:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ly8XYYipoD2ui1uOI6rBTuBqM3/79CjvaDtgsH2un6s=;
        b=XW3u26JgYxM1wF0meHea8JFbo6/nBp8Tbq8k/8JqspU60V3D0cWPitDsQNVpzGucGi
         e5idfJPecmpzQxuLu3YYTg+6/pIjMRj/wljhkLs3CiLRoc8tcGNsy3zx2fJPJu23vWFp
         qQ73j/UO8BhCvQfwblYcQExEZNk+nhshrwyq/U7N/m5uzkOuuG+/eC7WBHJ9Xmh+aR3k
         8C1AO1GG/Lwy/w7LpcLdxkpg9mwpmH6WIYQG+OD+x5bfZjKVwp9bg1/eXzyKcKSWjdW6
         ko0xT73YYqpjcY1GITCy5/ZMOhLqObx28zK+39Gd8uudmY+N/Q0e6QF4fW5XvmoBui+V
         hUaw==
X-Gm-Message-State: AOAM532l9FtUfIYm3uu5EcrGsjaX0QqmPDP+NklBVgj8eD8RZTJvUYRb
        +8d3SiV4Fuam9jy+SAeLzc1rJUH25uTOUXt+
X-Google-Smtp-Source: ABdhPJxSW5NiBVI2AeSdHNUlHFh2wl5ZhVlKxtXub5Ms8sBmwEilPwk668+BiEqh3eJrzR2ehxSh9A==
X-Received: by 2002:ac2:4185:: with SMTP id z5mr6821837lfh.391.1629301637805;
        Wed, 18 Aug 2021 08:47:17 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id j4sm23808ljh.120.2021.08.18.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:47:17 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>,
        Joe Perches <joe@perches.com>
Subject: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
Date:   Wed, 18 Aug 2021 18:46:42 +0300
Message-Id: <20210818154646.925351-2-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818154646.925351-1-efremov@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Properly handle commits like:
commit f2791e7eadf4 ("Revert "floppy: refactor open() flags handling"")

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/checkpatch.pl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..cf31e8c994d3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3200,20 +3200,20 @@ sub process {
 			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
 			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
 			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)"\)/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
+				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".+$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
+				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)$/i;
 				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
+				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
 				$orig_desc .= " " . $1;
 				$hasparens = 1;
 			}
-- 
2.31.1

