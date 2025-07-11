Return-Path: <linux-kselftest+bounces-37103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9074AB01D60
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E3A7BC488
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F072D7801;
	Fri, 11 Jul 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl0L0ViY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E66225409;
	Fri, 11 Jul 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240320; cv=none; b=PNrAANv+XUtuVfs5eThLj04E/t6RdqV2OP5nsvPl4q4rx1Iu/JICuwUKLtq+sCJrIA/j4yEJOF9Mqqx/Uvoo99+/WgdJxVBQFn3QP6siufJ4bmI4nT+tZ5T7/4uVkBYTeKCXB+YdgsyQCmQlQAkUJ4FWLFowAKOnYG3D4F8qDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240320; c=relaxed/simple;
	bh=eJtjrH8gy0v1B2l/1NsY9jCmHSjHw/XmPbkiPv2G4+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpg5nidGxMk5EDegZ53lSpCz9FEIXBxbdTVdcu0ufEt+jLCSIt733Pad9inaSE7WU8tNLnkxsTFxN5HxvP/Iqa2Tx6odgwFask6oM93SetvNoGGpAKwQ5QEjlI6Hdb485W3uQrzIncaRuiq4Emti28UryqB2rNQSm7XCoTuvtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl0L0ViY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9530DC4CEED;
	Fri, 11 Jul 2025 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752240319;
	bh=eJtjrH8gy0v1B2l/1NsY9jCmHSjHw/XmPbkiPv2G4+A=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fl0L0ViYW0bNk2kp3CRVmXI4gOiTl/4+o/XGQu6lmjMyGfElPjol3aSh/aWxHMKGe
	 limKlmHFPM5T3Nf0/smGl8K4CA1mTHyXU2JtFdFAr/xdxqUTPXFPYa9lRoGcSOkkQ2
	 YIhq1jHrHpQh+W9byUk34rDsKUS7Ug/Y364QcQFOcW6eBVNXY+IjEp1XZ7yql1VSqL
	 7M35mUCndMRKwzbpf1/NC9wmKxrmYF1sZMAFlbM1BAm9IXgDcyl4z5Ts4F+u9rWZtU
	 yvd70rgvkC59vLTs6iyMGJJCQTbM1W2ZIxof7Ui2GR+WUNzeqhNfO4eiIgK5S7iKw/
	 lXcpD+zsICNbA==
Message-ID: <00cfae5d-1e96-484b-b294-2fd54f5ad2b8@kernel.org>
Date: Fri, 11 Jul 2025 15:25:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2025 16.53, Thomas WeiÃschuh wrote:
> The function stubs exposed by module.h allow the code to compile properly
> without the ifdeffery. The generated object code stays the same, as the
> compiler can optimize away all the dead code.
> As the code is still typechecked developer errors can be detected faster.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

