Return-Path: <linux-kselftest+bounces-16667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFA963ED4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 10:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F0A1C23686
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F018A6D9;
	Thu, 29 Aug 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQETfUyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299FA95E;
	Thu, 29 Aug 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920912; cv=none; b=kVbKgu6bABoqPb1QU9V1qPXJCYuNhvhs329OnKPsgWOP9dt9qGq1JE8zBFjgpMlKqaWJ4yfgrtm2+tNlMYbDx8O7qUlLRpuJN62o/2O+3TDi/8c6Jg6VlWxekCjUhFLUyzkRdTTwHoQzJOvqWU+1+aj/+o5M/867kJZJFKJubMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920912; c=relaxed/simple;
	bh=8HRBD6DNPP4RHe53IvvNcMCos/yojmZ5jwfzKPWDlqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZBVV2ZkktCKfqqHSv1YrDex5os1xRH0vFhronHgG1S4TvDYH0cRc2yDr+hKhf43+svVqkAXgDWmBpU9iCd9WcYtPs27MZzrVUzpSUwy84U/PkLq7cVouvFYwJsvimCF4caeQW8+VxVzpyYnYZJRU1R2IkPDUAvDotxz1mJzyIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQETfUyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83EFC4CEC1;
	Thu, 29 Aug 2024 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724920912;
	bh=8HRBD6DNPP4RHe53IvvNcMCos/yojmZ5jwfzKPWDlqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MQETfUyjZk034CCXe1TfYMNLAHX1aNUgKSEg9FweEX5S7/xUGSLK1+Crk4lwiqwaV
	 KZ0A6EdfFgkoZL7wOxd1Pf9RAQNyD0o0rN3O1tIzNLfPVyszG4YyxqbkDaY9G6ARvQ
	 PkSMtw3KV3ZWfrC4Q80aGB/h/hDnnN65bz1BNqXCnEPI7faqTonYgIuFq1NpOYTkJO
	 WafgVXdTeEnsPdhge/6ykM0IqQ2RHtY7q9SFzJm/7xAdnz3hM8nG01l4aadvU3iP9J
	 OhKxcU1Mhj4j0WerTZtzrEnnDp1DNMPvgCBUAjiB9YBvlS6KpEJZ+mlXS4d+8+10d1
	 wF/i76vbVJNEg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
References: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
Subject: Re: [PATCH v5 0/4] HID: hidraw: HIDIOCREVOKE introduction
Message-Id: <172492091061.936766.13914253813022258960.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 10:41:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Tue, 27 Aug 2024 17:19:28 +0900, bentiss@kernel.org wrote:
> The is the v5 of the HIDIOCREVOKE patches.
> 
> After a small discussion with Peter, we decided to:
> - drop the BPF hooks that are problematic (Linus doesn't want
>   "ALLOW_ERROR_INJECTION" to be used as "normal" fmodret bpf hooks)
> - punt those BPF hooks later once we get the API right
> - I'll be the one sending that new version, given that it's easier for
>   me ATM
> 
> [...]

Applied to hid/hid.git (for-6.12/hidraw), thanks!

[1/4] HID: hidraw: add HIDIOCREVOKE ioctl
      https://git.kernel.org/hid/hid/c/b31c9d9dc343
[2/4] selftests/hid: extract the utility part of hid_bpf.c into its own header
      https://git.kernel.org/hid/hid/c/375e9bde9fc0
[3/4] selftests/hid: Add initial hidraw tests skeleton
      https://git.kernel.org/hid/hid/c/8163892a629c
[4/4] selftests/hid: Add HIDIOCREVOKE tests
      https://git.kernel.org/hid/hid/c/321f7798cfb8

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


