Return-Path: <linux-kselftest+bounces-9130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016258B74D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9542C1F22874
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB1133291;
	Tue, 30 Apr 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="Yz4YLsJk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7112D76B;
	Tue, 30 Apr 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477845; cv=none; b=lNaybM2TtEkwAft29FNz9Jt6ADeo/Igced9bvv3SX4qCnf7OHjNqWOB2s8yQsU0WPfANMuryWq6H6hjfTiAxxjEb9AE/b1DNTtqe4PyaM04K9gd0m6TKxMLByj43HSvlDE8UwIJH2Usf5Mssm0OKFxuo1JfqAFRYEWUF+2Bnuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477845; c=relaxed/simple;
	bh=Tu5t4kxrmarr+4UrOhU6m3uxZ7B/TAFw4gqJFUxfAcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2nFFAyl9GHRg7cQMWJ7WM7ugRSVqJcLNmxdgh22dgbeSWb8TZA5Udou1T2JnDcthHCklMCdbNDSCwNa1pjqT/wshEpwaz1XiXK3eOG2YfB3HTINCyaNDn3dbiWE23vZO0O+IkCxNTUMhKwPLg4OwqGLZqnWnV9T/6euDfeDJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=Yz4YLsJk; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1714477826; x=1715082626; i=kernel@valentinobst.de;
	bh=/A+2+zfwofr8ZeGQzVFabRyhfp0XLsUp/JabKpPvgcM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=Yz4YLsJkFHD/YIhbsTmDG74+J7gRg/5RwCX2BbbydX8v/RYABokavAoH+8A++kW9
	 pkAXOA4dQM6OwSl6oAEQ5QVLMtX0K92nzpG1cmhsM2/qyzEFfkizgU3grffXhu/a9
	 f1LD0So2NdT1mXnp5vkVskRTbvWBnDEyhVUR7bH2YyVDyZI3bdQCn5S646wkVlcQF
	 MuBZrHvM9guQ5PmSm6DUXmkxxpUVNEElJXCRHRGwLuC4GVVyRBE2T38F1mBYJ71Tc
	 v9JaMYKAcJP8rq107mUvCiXMwNaX4fbiUhw+7hEpO+Hv3byaq3j78vvB5hcQ2rmxE
	 Egx6/dG2Wf1rFDFcYw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.fritz.box ([217.245.131.25]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MCbMz-1rtpgb0Avj-009hOP; Tue, 30 Apr 2024 13:44:54 +0200
From: Valentin Obst <kernel@valentinobst.de>
To: jhubbard@nvidia.com
Cc: anders.roxell@linaro.org,
	bpoirier@nvidia.com,
	broonie@kernel.org,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mpdesouza@suse.com,
	nathan@kernel.org,
	sashal@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
Date: Tue, 30 Apr 2024 13:44:52 +0200
Message-ID: <20240430114452.432969-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <b728014e-9e8f-4b65-8d9e-ace0e2f6f18c@nvidia.com>
References: <b728014e-9e8f-4b65-8d9e-ace0e2f6f18c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:ihCwGuz4XS6xoYi2SCDTomFOQdrj/iFgf4Jjrqq/Ljexc7Dpohx
 a+QsMuVio+Mye/gIW6q2eP5ZOXvpM6T8rA3JpfvdaZn6WBM5+B8+YKLGUmDypfJ1yrx72Rz
 0N0vqE9xC6ZqSeq2/mp/FfCFvVqlpLL9wGaqQypfsQbR5w+H5SXLCGaeFiQSCZn4dvZL7c6
 2ffwOINURyBQW/baaQ1hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TglXCKDtlkE=;1Nrx+bbypK+Zc3OXZvxvj3oOJ8W
 WyWbrLHg91XPvA0XK7O0lR6sjkYkvqbglvT80WsLOFx8myUerz3cWIPxqce9iKp8Wm8McxzWf
 J1Sj8Cux9BOJFsbukSQJQcowa5046LngU/WeQh6YG5r40YmTydnQzRcIC6UhrW+xBtcoA6T65
 U5iojhWD0kT6E/kAE833Lknk5AHP7Uh/pfOQ3Dwiz0GgKjA2C78dJbUVQAPI5kD/ntMGw6Whn
 MNiz3KtE32uQJX4w73bVGF6iKsQmMkG1mdGvPh/P1x1H7xYEgH01toL/wxXkJxGd/Y+3ShvaN
 vMSfsaNPa2fIUS3c6cBFBTI0Yf08Z0pqwIT7iBmC3zJz6raf5BZMnU6fL/cpJUChCQl6xf5aU
 7U5aunFAq1SfMujYDkOwxSP5yIIaBZKCwR+MBKjiYNm+DRjFUwgJQX4TW3VjaetsFe/VjMaW+
 snDKe01GD2oNv62zDeubLsNXiN0llI+P5zV29j5xw6h/KZZbQhDORUfn5as1J1zTccaB/zy5/
 iz4AQAzAX2u8Y0RwTtCEr+6huXxoCDzSreJOXyaWLmq3pTk+wtmEFwpCmMIzcnshnpbCKqwKN
 SvXxunTnd0/A6Z8Su1Qx1DNqJUG3reTqlsPmpCbgt2mqon5fP6iEH6wG/tC2FUos+RUG5wbVh
 xhdv1t2Gew5m9u5SsdTpu9s8ePlWLd8Ux7F3YeSnH5MNuS21kMApAY7Xfk5BxrGNckjoiaUnC
 fHYyBE0wEja6mhCB+eKF0K2QAGXr5dOGXuemnyKJ4YstmJyMMci5OQ=

On 4/29/24 12:04 AM, John Hubbard wrote:
> ...
>>> And yes, the selftests "normal" (non-cross-compile) build is *broken*
>>> right now, for clang. I didn't realize from the patch title that this is
>>> actually a significant fix. Maybe we should change the subject line
>>> (patch
>>> title) to something like:
>>>
>>>      [PATCH] selftests: fix the clang build: default to host arch for
>>> LLVM builds
>>
>> Yes, I agree that the title should contain the word 'fix' somewhere. For
>> me its okay if maintainers reword the title when applying the patch,
>> alternatively I can send a v2. (Is it still a v2 if I change the
>> title, or
>> rather a new patch?).
>
> It would still be a v2, although the cover letter, or the section after the
> "---", would need to point to v1 so that people could make the connection.
>
>>
>> Any thoughts on whether this also needs a 'Cc stable'? Its not quite
>> clear to me if this fix meets the requirements. As above, no
>> objections if
>> maintainers should decide to add it.
>>
>
> Maybe not, because it doesn't seem urgent. But it's a judgment call.
>
> By the way, I've been chipping away at fixing clang selftest build
> failures and warnings that are only visible after clang is working again
> (due to your fix here), and I'm up to 30+ patches, and probably only a
> few more to go to get all of them.

Thanks! There're really a lot of those.

>
> I'm expecting to post the series soon, hopefully this week. And I'm
> thinking maybe I should carry your patch as the first one in the series,
> in order to ensure it gets picked up. Or, I can just refer to it as a
> prerequisite in the cover letter.

Correct me if I'm wrong, but intuitively 30+ patches that touch selftests
from many different subsystems do not sound like something that is going
to be merged fast. Since I'm also planning to send a separate series that
removes explicit setting of `ARCH` from subsystem Makefiles (if they do it
for the sole purpose of working around this issue) I'd prefer to leave this
patch separate for easier reference and potentially faster merging.

Referring to it should hopefully be sufficient to prevent it from being
forgotten.

	- Best Valentin

>
>
> thanks,


