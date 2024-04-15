Return-Path: <linux-kselftest+bounces-8021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE98A5A7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588791C20FF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB1155A59;
	Mon, 15 Apr 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGK0BRqb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E4154BFB;
	Mon, 15 Apr 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208764; cv=none; b=qODEZhDPOgaogWIYipYbJHNpyJdXszBZYurd/RoXPkqsDBFb4XLTo3g7q59ce9cqRYiuoJMJfTCJz+zUHIkph8e2/es003eRvAHbeEY/74Zt/jtfDmGylp3em85n6JF6NRSjoyuE5F4HIfJQvM8/w3cDjJyX5QoVaYjODGvz1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208764; c=relaxed/simple;
	bh=sI4q7yQQr/xKTWwbqdFN7vJ7fFl0Qz5qidReAD0dIBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Ft33g0xw7CFyC4oIKZuULBl92U9d0o39rrH7ZjCwwt2LijTjEuC+Epxbx6fQwSIdd9HfbhTFzFm2vQIIT4n5jwK3U315gLftHTipRma+MBwJdRGsM3Sc8+8AeuoB3+6rkD1TmSMeGKI7i//T9VQb95u3/rkKmtenSScfmISUq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGK0BRqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B58C113CC;
	Mon, 15 Apr 2024 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713208764;
	bh=sI4q7yQQr/xKTWwbqdFN7vJ7fFl0Qz5qidReAD0dIBY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UGK0BRqbLphCLl0gZ/rvNphxxFExYtA9FygBsF661QP3rx9EYc+FnHSsdlkxATGgM
	 kTYnWA24nPDa7+3/aITid2exhO/pd3LlBbwW6yHWUg79JJzb9K+BJ+nIwfgHmz2zqX
	 Y12J7kYqgyB2+tM/+WAPiiNjlQs0N4iF+ied2m77DLrK/zzFcTwdM6wLCXdnri3x/E
	 QzNNS65u5siRpGo6kC3e2EYw2fCS425BYMaCLGmcJzKYXd4UqTWFdu26JdEdNbErwt
	 0QYh0qPwqEwCO0g5YpcMUYdpwQH6EkK7XAQb44tcyXUhPbNK2LiE12iVfCedagCEL5
	 wUqlh6qYvVgkQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:19:16 +0300
Message-Id: <D0KXTHHYLSX6.1IDLSEIVS9PA5@kernel.org>
Subject: Re: [PATCH v4 01/14] lib: Add TLV parser
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-2-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add a parser of a generic TLV format:

What is TLV?

BR, Jarkko

