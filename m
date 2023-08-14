Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4277C25C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjHNV1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjHNV1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 17:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E368B3;
        Mon, 14 Aug 2023 14:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 220C36217F;
        Mon, 14 Aug 2023 21:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3C5C433C8;
        Mon, 14 Aug 2023 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692048454;
        bh=ROTw5Shu1qnV11NIDTQkvpaBafpBtU+9vSUPGkEv9rk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oIKwP8elZUnZFrS7Axf1DTHkNw0siHSXXuF+b5QvVIJvtoQoB9h+RctPmiH6aMBPk
         FLAQ8C0mf1g+vIuV7jjG7+LbpLsXa7Aafmtwy9hCmhDmWAeVUZA7sz4uf2f3dVqvJo
         CHxz4iWvYCe4Bjx44shhyRzl3LVuCmqVkcsnyvkHPJhT/mxgFpSKATYrQ1fq0U/AMf
         Aj6RJEfDovg2k2t86nSMYFch5Zdh1wxJZahQ+XPrclc9Hr64gK0F82RDuWEonRETrm
         GJE/HgbsmQgSTtrHwvh+vJDvuvQWSM6QX1RWgbv6ac9KUIngWmPEnA8j/I5eut23Ol
         jtp6FC2H9f0Ug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1BD30CE039C; Mon, 14 Aug 2023 14:27:34 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:27:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Copy out ftrace into its own console file
Message-ID: <8f952ce7-2122-45a4-82a3-a4e4dcd85ff4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230813203602.GA696907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813203602.GA696907@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 08:36:02PM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Often times during debugging, it is difficult to jump to the ftrace dump
> in the console log and treat it independent of the result of the log file.
> Copy the contents of the buffers into its own file to make it easier to refer
> to the ftrace dump. The original ftrace dump is still available in the
> console log if it is desired to refer to it there.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued, thank you!  I did the usual wordsmithing, please see below.

I also fixed up the indentation and spacing.  I don't know about you,
but the initial format made that a bit hard for me to read.  ;-)

If there are multiple ftrace dumps in a given console.log file, this
will concatenate them.  Is that the intent?

							Thanx, Paul

------------------------------------------------------------------------

commit ce1cf26540b96fc52aec6f6f8e365960ca79a0ad
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sun Aug 13 20:36:02 2023 +0000

    rcutorture: Copy out ftrace into its own console file
    
    When debugging it can be difficult to quickly find the ftrace dump
    withiin the console log, which in turn makes it difficult to process it
    independent of the result of the console output.  This commit therefore
    copies the contents of the buffers into its own file to make it easier
    to locate and process the ftrace dump. The original ftrace dump is still
    available in the console log in cases where it is more convenient to
    process it there, for example, when you have a script that processes
    console output as well as ftrace-dump data.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..40bcddf5f197
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,27 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output looks in the logs looks like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+	awk '
+	/Dumping ftrace buffer:/ {
+		capture = 1
+		next
+	}
+	/---------------------------------/ {
+		if (capture == 1) {
+			capture = 2
+			next
+		} else if (capture == 2) {
+			capture = 0
+		}
+	}
+	capture == 2
+	' "$1";
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
