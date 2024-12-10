Return-Path: <linux-kselftest+bounces-23101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15FA9EB022
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 12:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8263161F64
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC26194A73;
	Tue, 10 Dec 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8cAOW1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FB78F39;
	Tue, 10 Dec 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831254; cv=none; b=pxA7T5pDHvRV6GbvlUDBQWEUcjuPB1lRFVkuw6k9kcrmORbXleQsLHeXEEbSAZ+kLRY80xfoiON7XYzfWa2qtmtRlwTvM3ufWeiHrBOS0KNd35jDdZbn9xcEeQnHoNvYKKGr5XQm/HE9Zm5reEzbyQpkNT7qAnWcNiYDTzazxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831254; c=relaxed/simple;
	bh=xeaKZ6Zh12zOV56MPcBBK+1Ah2/Vptqi1xrxfq1lNzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IEdvkQZpH1gnD+im4DWcdULl3Vx9EvOs9VgJRphFW7lhHSjzPaQ91d6SXOv4CS+zpmY7aaYL9OD0BwfB0HPlAYUt7L7i8zmInGYwDpPQfZX/MGnp96/n8hPF1mFhGagzUByL6RNDRUhLT6MWwj7zxuYTvYIjDzA+DCzcWmOC4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8cAOW1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88464C4CED6;
	Tue, 10 Dec 2024 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733831253;
	bh=xeaKZ6Zh12zOV56MPcBBK+1Ah2/Vptqi1xrxfq1lNzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Z8cAOW1z+7lwVayv75V0xX71LIHqOPD8CvmeQuSPAQN+lii0rnw6qyGqC5FPh1nPp
	 iiSM1zo6yk30ZDEFeLyx9UZT7SEhj3I9tz2L+qZUev/BzrrF4ReA7THg+dV90a1Qsj
	 jrVLCxaz/EjlnNyaWPpCYRuPJG3gFiwIj2hYFrCmJo+KLzbBK8gF7nWR6alMsxciLu
	 B+yTM+LKMSbFLKvfSic8XG+ubbKmBh9gmOoL4yE6+Oa0aXPmJLZP48vqkCRKFW8hnI
	 cf0jGez6aoh8MqunRNAuNwNNyRhBDl2R3eugjInigyA60n9e5HvEJb7XzyUL3Yy0Wm
	 hEf7H+cibj8Aw==
Date: Tue, 10 Dec 2024 12:47:31 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Shuah Khan <shuah@kernel.org>, 
    linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/hid: Add host-tools to .gitignore
In-Reply-To: <20241206-host_tools_gitignore-v1-1-e75e963456dc@rivosinc.com>
Message-ID: <22p16770-9s00-876q-onoq-q9p204716n72@xreary.bet>
References: <20241206-host_tools_gitignore-v1-1-e75e963456dc@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Dec 2024, Charlie Jenkins wrote:

> When compiling these selftests the host-tools directory is generated.
> Add it to the .gitignore so git doesn't see these files as trackable.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs


