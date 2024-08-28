Return-Path: <linux-kselftest+bounces-16561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB51962D21
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61611C21318
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27321A254C;
	Wed, 28 Aug 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrh255zR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7D186E26;
	Wed, 28 Aug 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860882; cv=none; b=InTGF7hV5hzloSpwP1VgWU2uO8HyoSpsk3NQet2b6lgMrDIlaYkdb0917W0hNgRfhr8XCemaQe/Cwj8CzA2EC1MOLAgd+5YUn5xlRP4QouiMaj2Qpus1c4tMzJFR4W1F6Kmw7oiV4Yf/zrm2kcHPTQ6FI786OTRX3AHfnLR4ceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860882; c=relaxed/simple;
	bh=CAi4Muk4AipUnOLqWPWkEMgQGCtB6VKz3wqG4OS/i9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2Racu9fTfQaXyj+vpIlFVw+umjHSKmXjsgLsfBqQXEsIxobOWI1RGiU/sfE9gnrTLNb9XpMgDrYJBElBZyUNXbP5u2bMHOaadlpyS94sVE/qzzRx3K1X/zGdaflzuWmssheNV8Gd76vTm62zE7BazuqEj0TiTNxH3B+F14srhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrh255zR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8391C4CEC6;
	Wed, 28 Aug 2024 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860882;
	bh=CAi4Muk4AipUnOLqWPWkEMgQGCtB6VKz3wqG4OS/i9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrh255zRosyRxkzYuCQG47MKbD2Jzw49eXc5QI2Fz/Ze3YDg5g6c6oE0pxeMbgLyT
	 a2iby+DRzhjLh80CYD5CfCXW8JZHbLJg8VthsaZn+FCtAOD83pV89bCgme6qiFfR0U
	 jADJ7YKhmXHtkwElLb1p5tBFQSI3t3xR4kZv+pKNRu+r3XTL6+rqNst5xKUwQMDOu/
	 j8KY5LOgpEiWRkGr9EFz57juijmStRzX6kvA9kGys946fYysoVNiigbO4QDsHl4Qgl
	 4uylPqaySrOcquyGIsR6VQN/8XTCp+5uayRo80SZerapZPeZYSCDCSO+ZcU3IRa08c
	 PK+GdALeg1QZw==
Date: Wed, 28 Aug 2024 09:01:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 martineau@kernel.org
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240828090120.71be0b20@kernel.org>
In-Reply-To: <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
	<66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 10:03:55 -0400 Willem de Bruijn wrote:
> > > A single script is much
> > > simpler, optionally with nested KTAP (not supported yet by ksft). But,
> > > I'm afraid that running time without intermediate output will be very
> > > long when we integrate all packetdrill scripts.  
> > 
> > If I read correctly, this runs the scripts in the given directory 
> > sequentially (as opposed to the default pktdrill run_all.py behavior 
> > that uses many concurrent threads).
> > 
> > I guess/fear that running all the pktdrill tests in a single batch would 
> > take quite a long time, which in turn could be not so good for CI 
> > integration. Currently there are a couple of CI test-cases with runtime   
> >  > 1h, but that is bad ;)  
> 
> Very good point, thanks! This is the third packetdrill runner that I'm
> writing. I should know this by now.. Let me see whether I can use
> run_all.py rather than reinvent the wheel here.

Do we have to worry about this now? If you're planning to add a runner
specifically for packetdrill... IDK if we should. We already have a few
runners, not to mention that run_kselftest.sh itself can run all the
test cases in parallel in separate network namespaces!

What I was wondering is whether we can use shebang to direct the .pkt
files to be "executed" by the python script. Alternatively we can add
support to specifying "interpreter" for a given test in ksft infra
(kinda like we can pass cmd line arguments to a test). Completely
untested but it should give better idea what I mean than a description:

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 74954f6a8f94..429c279e9c6e 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -56,6 +56,7 @@ run_one()
 	export kselftest_timeout="$kselftest_default_timeout"
 
 	# Safe default if tr not available
+	kselftest_interp_ref="KSELFTEST_INTERP"
 	kselftest_cmd_args_ref="KSELFTEST_ARGS"
 
 	# Optional arguments for this command, possibly defined as an
@@ -78,6 +79,14 @@ run_one()
 					$TR_CMD [:lower:] [:upper:])
 		kselftest_cmd_args_ref="KSELFTEST_${BASENAME_SANITIZED}_ARGS"
 	fi
+	# Optional interpreter to run the test case
+	if [ -n "$TR_CMD" ]; then
+		SUFFIX_SANITIZED=$(echo "${BASENAME_TEST#*.}" | \
+				       $TR_CMD -d "[:blank:][:cntrl:]" | \
+				       $TR_CMD -c "[:alnum:]_" "_" | \
+				       $TR_CMD [:lower:] [:upper:])
+		kselftest_interp_ref="KSELFTEST_${SUFFIX_SANITIZED}_INTERP"
+	fi
 
 	# Load per-test-directory kselftest "settings" file.
 	settings="$BASE_DIR/$DIR/settings"
@@ -110,8 +119,12 @@ run_one()
 		if [ -x /usr/bin/stdbuf ]; then
 			stdbuf="/usr/bin/stdbuf --output=L "
 		fi
+		eval kselftest_interp="\$${kselftest_interp_ref:-}"
+		# Add a space at the end if interpreter is set to work in $cmd
+		[ -n "$kselftest_interp" ] && \
+		    kselftest_interp="$kselftest_interp "
 		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
-		cmd="$stdbuf ./$BASENAME_TEST $kselftest_cmd_args"
+		cmd="$stdbuf ./$kselftest_interp$BASENAME_TEST $kselftest_cmd_args"
 		if [ ! -x "$TEST" ]; then
 			echo "# Warning: file $TEST is not executable"
 

