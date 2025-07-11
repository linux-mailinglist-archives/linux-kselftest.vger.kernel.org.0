Return-Path: <linux-kselftest+bounces-37118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918BEB01ED6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491B3643223
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB272E041A;
	Fri, 11 Jul 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx8P7Bjw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950B2DE714;
	Fri, 11 Jul 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243450; cv=none; b=O5GZNLpNG0m62dKTdmp0t79kum5KyfYAePb0BOrdgGsZ4V0kxBKg/8y5NIhzIDxx85CcHhLrAYoG2Wab0tFcIGRKT1wuIwqp/Hr8BTHqdizv/e4cNiMpEJ/7tn9Gbm3urrp2aHA8jz6yhkh4Im0mApzgVYjIRN/SWIzPQMQ3+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243450; c=relaxed/simple;
	bh=DcQ8YFzACpBfkZpYRl9/s4IH526vfkvz/mvzHDQFk/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdFojEF1lcZThw6MhjIOxSd6Sn12yJGFidgRWFnAPM7EYf+TggllDNUzYcnn55OPFjpL9saU4Dq/sBetRSGXvF8g2ndA62tG4UIJ+fbfwqlqwGdwDPP/tc/e+xjXHGIGm7SR4pndP3hr/dgRZ6DZZe8QY1RNKtq8dF8Xfb2n0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx8P7Bjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244FAC4CEED;
	Fri, 11 Jul 2025 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752243450;
	bh=DcQ8YFzACpBfkZpYRl9/s4IH526vfkvz/mvzHDQFk/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nx8P7Bjwn3bxEnhL8vZEl91fhd+HU7UzV2CnBasHeDo+lFwg9OxOraPax2R3cimxy
	 SnolkBz9yZgeFy4rsMXZ5Y1MzlcCcfUB1A08yLi0duGbLVWa0JwidAfsJjvTOEyyud
	 GeZPAjWIxXrA7UX0pYmHwyYm2jzHMxesFgdw55gU4e4Ve+lnFssEtooTxx9UmAdm10
	 ijZcfwZm9TS6kmc0tLQ5U0riN247X9G0S2p2CYe9G/MI9RnRhD6fDEGrTJjRkE9e5z
	 sF2MQigIV09FsexQ0t8atgvEip1Z6vMCdHeGD5hqoU1XBFDquMemqPHYq229crCukR
	 U/wTH5F4VZorg==
Date: Fri, 11 Jul 2025 07:17:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: try double sleep to give WQ a
 chance
Message-ID: <20250711071729.14d727f6@kernel.org>
In-Reply-To: <aHBza5P50wcKjG_h@fedora>
References: <20250710145312.3361964-1-kuba@kernel.org>
	<aHBza5P50wcKjG_h@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 02:14:03 +0000 Hangbin Liu wrote:
> >  	sleep 5
> > +	# Schedule out for a bit, address GC runs from the power efficient WQ
> > +	# if the long sleep above has put the whole system into sleep state
> > +	# the WQ may have not had a chance to run.
> > +	sleep 0.1
> > +  
> 
> How about use slowwait to check if the address still exists.

Weirdly if we read the addresses twice they disappear, I haven't looked
into the code for the why, but seemed like using slowwait could
potentially mask the addresses sticking around when nobody runs 
the Netlink handlers for a while? Dunno..

I queued this debug patch a couple of months ago:

 	sleep 5
-	run_cmd_grep_fail "10.23.11." ip addr show dev "$devdummy"
+	ip addr show dev "$devdummy" > /tmp/a
+	run_cmd_grep_fail "10.23.11." cat /tmp/a
 	if [ $? -eq 0 ]; then
-		check_err 1
-		end_test "FAIL: preferred_lft addresses remaining"
+	    check_err 1
+	    cat /tmp/a
+	    echo "==="
+		ip addr show dev "$devdummy"
+		end_test "FAIL: preferred_lft addresses remaining ($lft)"
 		return
 	fi

And when it flakes the output looks like this:

# 7.23 [+7.00] 297: test-dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
# 7.23 [+0.00]     link/ether 9e:a6:c4:c2:1b:16 brd ff:ff:ff:ff:ff:ff
# 7.23 [+0.00]     inet 10.23.11.81/32 scope global deprecated dynamic test-dummy0
# 7.23 [+0.00]        valid_lft 0sec preferred_lft 0sec
# 7.23 [+0.00]     inet 10.23.11.84/32 scope global deprecated dynamic test-dummy0
# 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
# 7.24 [+0.00]     inet 10.23.11.93/32 scope global deprecated dynamic test-dummy0
# 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
# 7.24 [+0.00]     inet 10.23.11.94/32 scope global deprecated dynamic test-dummy0
# 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
# 7.24 [+0.00]     inet 10.23.11.97/32 scope global deprecated dynamic test-dummy0
# 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
# 7.24 [+0.00]     inet 10.23.11.99/32 scope global deprecated dynamic test-dummy0
# 7.24 [+0.00]        valid_lft 0sec preferred_lft 0sec
# 7.24 [+0.00]     inet6 fe80::9ca6:c4ff:fec2:1b16/64 scope link proto kernel_ll 
# 7.24 [+0.00]        valid_lft forever preferred_lft forever
# 7.24 [+0.00] ===
# 7.25 [+0.00] 297: test-dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
# 7.25 [+0.00]     link/ether 9e:a6:c4:c2:1b:16 brd ff:ff:ff:ff:ff:ff
# 7.25 [+0.00]     inet6 fe80::9ca6:c4ff:fec2:1b16/64 scope link proto kernel_ll 
# 7.25 [+0.00]        valid_lft forever preferred_lft forever
# 7.25 [+0.00] FAIL: preferred_lft addresses remaining (1)

