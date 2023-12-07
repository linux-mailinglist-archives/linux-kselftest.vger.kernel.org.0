Return-Path: <linux-kselftest+bounces-1352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E88808998
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE852828E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4C240C13;
	Thu,  7 Dec 2023 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6kZrSSH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604540C0F;
	Thu,  7 Dec 2023 13:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782AAC433C8;
	Thu,  7 Dec 2023 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701957324;
	bh=+M4tBRVeONvinQiPUe/26L3bNkUxaoKm0nKn0+RekqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S6kZrSSHYpzCqReIM3C1ykyP7P1hNS4w6ZwgZpsciCIKOBj8Yqe52bGZLRlsFL3wQ
	 WwYgeNX5u8JpfZ3COQ2crDnS+0IvSYfWbpPfrAygCv44ZukWdQAG2KEnEkOt7xbf65
	 ysz01BkNQp0eyQt0Z6fLqybbvEZ7qBjsUoyqYCZLqkQMJRp8wIq4FaqBLg9JxlxkdA
	 apSm3gsUffz41NpJkx6LoAYYe+pQKoxIr/WvZx5kVLryf/H6xKZh/ttjgT77gA/uge
	 BZPvw+Al87+cZmE9JVJok31H4nmH2TMLj4w6g2jlMJsv3yhDQyxCti6r1NmV3XMbfa
	 O4UNNrkv8dIaA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
References: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
Subject: Re: [PATCH] selftests/hid: fix failing tablet button tests
Message-Id: <170195732222.272144.9548310511759947709.b4-ty@kernel.org>
Date: Thu, 07 Dec 2023 14:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Thu, 07 Dec 2023 13:22:39 +0100, Benjamin Tissoires wrote:
> An overlook from commit 74452d6329be ("selftests/hid: tablets: add
> variants of states with buttons"), where I don't use the Enum...
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.8/selftests), thanks!

[1/1] selftests/hid: fix failing tablet button tests
      https://git.kernel.org/hid/hid/c/da2c1b861065

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


