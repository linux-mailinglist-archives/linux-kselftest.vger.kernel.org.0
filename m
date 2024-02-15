Return-Path: <linux-kselftest+bounces-4713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AB285584C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15046289C3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B68391;
	Thu, 15 Feb 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN3RcBV4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849C38D;
	Thu, 15 Feb 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956715; cv=none; b=f3pEnQiXgKlbaQ4QS7jeXRrCBm+hoiJOOyRaKN1NF4UV0sSpYsToke+ax1vRJoxdbfz27NYSek86IYlZKN6Av08revlYQlo8hc+lOjzk5A4i+GOzwf6SK8EMiO8cTUGukFvMOPe6/oSdrmaxcDG/UXPLhR+mkk6vCI5ILRGnxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956715; c=relaxed/simple;
	bh=gOMOiAiGSlIqnFFLDxvgvxJAtnCqDrleDRQOc374xIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM7mLMdDcVOOT/c0jRHDclUZs3DgFh/ZsKOx4HtmT7D7a3Cz++VbSgL5tXuRUdry7U51HSvnsvAO4cXjtHxquLfgEpgR4EywyQcecJOetTG2LYhLcrOJXl+GVDNoyN5d1ZcRE/I3yEWzwMuQY+kyLv3Sfw9nMlu3NJUHAVO59G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN3RcBV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0939FC433C7;
	Thu, 15 Feb 2024 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707956715;
	bh=gOMOiAiGSlIqnFFLDxvgvxJAtnCqDrleDRQOc374xIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sN3RcBV4AUgrenUj270nUBtbQ/GT7L9hb3Y5Bm1pr1ggDWxUCqZzFilB5bVKixz80
	 PYlyrzki2RlSSAdRV2svHHu8zH5hJOWhZh4R8we7OXjcw3Tz9jxp2kpUA2p60DQlgQ
	 DqN5hH4Tcf9Qkf7Gq/YdvNnppTeaxnrZHz0ZWlIxuoTf9Lz5tF/mumoLnLTi1IxD8v
	 zPRhO2Ql11sS5KVAlqy2tvw6mOZ28zcp4fGLwvdUQ7R/s9Q41/MtSAE+Qm7u+zbFch
	 f10snLabDgM5DqTtK0PP2Nr86oC7Y2YD0DUOLWFX2KQxzN7FlA+2HWk77qYtLmqYaQ
	 WVYnHiDGwEKOQ==
Date: Wed, 14 Feb 2024 16:25:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>, keescook@chromium.org
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240214162514.60347ac2@kernel.org>
In-Reply-To: <87jzn6lnou.fsf@cloudflare.com>
References: <20240213154416.422739-1-kuba@kernel.org>
	<20240213154416.422739-4-kuba@kernel.org>
	<87o7ciltgh.fsf@cloudflare.com>
	<87jzn6lnou.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 22:46:46 +0100 Jakub Sitnicki wrote:
> > On second thought, if I can suggest a follow up change so this:
> >
> > ok 17 # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> >
> > ... becomes this
> >
> > ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> >
> > You see, we parse test results if they are in TAP format. Lack of test
> > name for xfail'ed and skip'ed tests makes it difficult to report in CI
> > which subtest was it. Happy to contribute it, once this series gets
> > applied.  
> 
> Should have said "harder", not "difficult". That was an overstatement.
> 
> Test name can be extracted from diagnostic lines preceeding the status.
> 
> #  RUN           ip_local_port_range.ip4_stcp.late_bind ...
> #      XFAIL      SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> #            OK  ip_local_port_range.ip4_stcp.late_bind
> ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> 
> It just makes the TAP parser easier if the test name is included on the
> status line. That would be the motivation here. Let me know what you
> think.

Good catch, I just copied what we do for skip and completely missed
this. As you said we'd report:

ok 17 # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT

and I think that's sort of closer to valid TAP than to valid KTAP
which always mentions test/test_case_name:

https://docs.kernel.org/dev-tools/ktap.html

We currently do the same thing for SKIP, e.g.:

#  RUN           ip_local_port_range.ip4_stcp.late_bind ...
#      SKIP      SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
#            OK  ip_local_port_range.ip4_stcp.late_bind
ok 17 # SKIP SCTP doesn't support IP_BIND_ADDRESS_NO_PORT

I'm not sure if we can realistically do surgery on the existing print
helpers to add the test_name, because:

$ git grep 'ksft_test_result_*' | wc -l
915

That'd be a cruel patch to send.

But I do agree that adding the test_name to the prototype is a good
move, to avoid others making the same mistake. Should we introduce
a new set of helpers which take the extra arg and call them
ksft_test_report_*() instead of ksft_test_result_*() ?

Maybe we're overthinking and a local fix in the harness is enough.

Kees, WDYT?

