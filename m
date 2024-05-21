Return-Path: <linux-kselftest+bounces-10486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94548CB4FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 22:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4041F22D35
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2C149C71;
	Tue, 21 May 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tiws/Mon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D014901B
	for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324966; cv=none; b=Ixor41lYeXvj6lS0F7jh08FTgFO5uEtdfCQSkJ+5N7lRW1cjn1y/yRb6x1F7Dhzdn4QUwcwVoixdEOtmDfISX++pfN2I9AaNAgZhxQJW8XGjV1ZA4oPM0Ur5iCDOOZXBRoahys+9nxpchy8nJeNt92IVOMPmNKk0F616f65LF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324966; c=relaxed/simple;
	bh=MJiaqEAU9sSWZ1B+ERJ2EzFdFTRMHtGeptWAmPSNdbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q25a2nFWd1CZmZmkoOppwW4Dw73ZcEeSsr/KvjM3IjuxkG8mupZXDh7Kd5aE2DMcKsXpHl9PhqvxqQpEzM7ZOZoLPAzeI88uGXVx0wUtzgOgGF/wgCTBJn1CuLtnOcq5B+rc+7JuPXCO6HpEpHfWxy8wtE9NBYvq/5vQR0wZov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tiws/Mon; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23fb9c871c8so2273504fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716324963; x=1716929763; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJiaqEAU9sSWZ1B+ERJ2EzFdFTRMHtGeptWAmPSNdbc=;
        b=Tiws/MonIon6cnbOMs+FdnaKxtRNYkO7DdF8WvLW6zJDCgjy/w3ikKcVuA4R1pf6yd
         IaeAurCMkojwjWJOV05TodcuN75c9Ff5EsWi69WZzuXPIXTlargkQdcJtqzGgIbslOQr
         8O8B+wn/3Hg+Zba5h63pQYdM/NiYo1t1n9E/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324963; x=1716929763;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJiaqEAU9sSWZ1B+ERJ2EzFdFTRMHtGeptWAmPSNdbc=;
        b=VkiA5dOlSBfXX7ZPTVt0Fp1NKMsW4cJp17GXTnAFGRYdyhrtb//cZ/duEjS/sZwIRH
         d8kxTQ/j0qyMbirWzKbNlyM8E1rZOgXcqkb31R2ye2kfnB6yEYWpRsu8+PzFWJagx8tg
         gWlw8vt8H3fpf4T9/SxZllbRg8iSx9w7Lc8KSmDXtZBOhN/va4/+eaepBPUjgEBSXdim
         tSqiRZGKhdieFdFq/j+z5bPSiGUn4CkFBSaXpqGzDnGsEbhmElqh6ZldtUgX3Z8S0oKX
         QzeFB1ncy3VIKd3goE8gAx9+wACa4H5/R69cnWEuS90Axm8j+ffvz3icgFXKP0OEYIF7
         4UhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqR2/W4IV7ZzuRt36Gz162ezqXKwGtHspr3uglexLzB72XCb9cQ04rDPyVUfHKKQy0YR7rPJny1hIYDH5OJ3fiq+GipPvnbBO+8+k028+o
X-Gm-Message-State: AOJu0YxGeS1xhuz8vrhTnpR5yxxkztC3SBXi0L3BUgrSonw+nCCaddri
	Ex7uK6EWGZ5CSbYfcegCyJ2eFmH5H98eOv4SncQ7h+wWLmFNbTo+40yrR3t6H4vKOHe7KEeT31n
	B75wXQ5PDZVDjkV/Q9DARfKrXpiPAWg1Mb7bsIoe8LZ1NZVg=
X-Google-Smtp-Source: AGHT+IFVKWZED7guJzc+MzWuGHfaHJUwnJp1kEX7pxfEdSQdnNlThEftDlYt/MqxHChTBxk0kLBrMDZyswbZxiDXzxE=
X-Received: by 2002:a05:6870:b00e:b0:239:8687:d01 with SMTP id
 586e51a60fabf-24c68aebafemr258687fac.6.1716324963212; Tue, 21 May 2024
 13:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
 <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com>
 <3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5ntgk5a2rx@jkccjg5mbqqh>
 <CABi2SkVLqE7WD2MTYpksxA3+BfLLzjibHeJy9saYFvM-GRFy-w@mail.gmail.com> <khduyf47rifr5bmswkbju6l5itldhqaksjasvnkfhg4ig3ngdc@a4c2csfsdeqz>
In-Reply-To: <khduyf47rifr5bmswkbju6l5itldhqaksjasvnkfhg4ig3ngdc@a4c2csfsdeqz>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 21 May 2024 13:55:51 -0700
Message-ID: <CABi2SkU+6tSO6UASTW+7WNX4ySot5FPz5shnjE8b1OeXyJu-=w@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:00=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
>
> TL;DR for Andrew (and to save his page down key):
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
Many thanks!

-Jeff

