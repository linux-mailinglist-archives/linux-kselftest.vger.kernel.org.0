Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1286B50D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCJTVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 14:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCJTVG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 14:21:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D91219FC;
        Fri, 10 Mar 2023 11:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F10E61D47;
        Fri, 10 Mar 2023 19:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B580C4339B;
        Fri, 10 Mar 2023 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678476065;
        bh=h96RzPVmfu4a9Zs2dUbwmPcGcesOoRHMhOcR2gVxLLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQaNtV3XbPWoEfrXdeuLV5g9naMD/sFMoCZ6lxQb5RyxrksCAsnLrISfzDnf9mBO/
         cUAIqaz+faLwjLk1rcXrKKJIoF0GFVjZkpumZk/CgeVwgIWGPWwC2D08xCMB61blw9
         2Jgm4A9UVIa7GtRwWAT8g28cLlI9O9XMuhu9Xz6IeSD0V4ulxudAXQRRUPOdBOjcdZ
         19+xhexZ5u+orIWCvWPU9sP1Ci+Ns0UqIFa2/j2LsrmOH1VDRyiFLnNmigDlsnnKiy
         BfSFSatEB7NW6auBhRRQeR+XlAjI8UqmsWgB8vLvIs4N7ll32/0N4Q8V99hGuu29rG
         00wrjnDL2szEQ==
From:   Ross Zwisler <zwisler@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 2/3] leaking_addresses: also skip canonical ftrace path
Date:   Fri, 10 Mar 2023 12:20:49 -0700
Message-Id: <20230310192050.4096886-3-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230310192050.4096886-1-zwisler@kernel.org>
References: <20230310192050.4096886-1-zwisler@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

scripts/leaking_addresses.pl only skipped this older debugfs path, so
let's add the canonical path as well.

Acked-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 scripts/leaking_addresses.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 8f636a23bc3f..e695634d153d 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -61,6 +61,7 @@ my @skip_abs = (
 	'/proc/device-tree',
 	'/proc/1/syscall',
 	'/sys/firmware/devicetree',
+	'/sys/kernel/tracing/trace_pipe',
 	'/sys/kernel/debug/tracing/trace_pipe',
 	'/sys/kernel/security/apparmor/revision');
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

