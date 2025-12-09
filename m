Return-Path: <linux-kselftest+bounces-47290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED375CAF24D
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D95CE3009C26
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742121C16A;
	Tue,  9 Dec 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MbjYCADh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF711F4C8E
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265576; cv=none; b=iF1n0XY7Msz9rsj06PdoTWV8CMYy3ICsrxoeEkcwFyULOChXYwwJl3wxhSG4SLvhTsxZkE9sG/gfA7gZelq/F6wJ0umKSMrNtSQ4PWCLsmOjZugzbYVlJay5NEzWyHSiCIwg5/1cKcjDzMqoHmBMSW1Pfdm5fMWSS1WEoT1gU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265576; c=relaxed/simple;
	bh=8nT8939qWUoJYlT2R7sKtRouAfpezWZVT5T0CEHq2FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0G+dHgJzyqMZJMLuVenmQfQdOOBMXJGCl4WqCxvjFZVveGSFkYuwQw0sp/OWvdOLd0eHmVS2yIfYq6fjNy/gYIbo1zyaycEiHt5ppAdUIiQuBLV/HehfLZ36yuuQHIV+au68JyZKKfR1EldOPpDXlsLYyPyJRWDDe6pDzs19Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MbjYCADh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so9028019a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 23:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765265573; x=1765870373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=MbjYCADhgfbS1x2TvvOLLtOmzz8tpcASJtSAl+aVRWhDYIdTRDzEZ9nZafLiIC2PiK
         aCVqLCGIiqmYFrmxk0ckl2hFtpLUREwDZm7wBNCHZu3rdLLdUbyR1ogguIBD8OOWomj0
         w8He1HUckMDDHYj1MJFIXr0tbmtp3uaAT8NRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765265573; x=1765870373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=XQ1ecP8r7PBkaf9cF6AQXRj7yzbmD6edfOP3cW9ez70W7vGVznSyYGoK48PEfVU9kw
         yMQK4/rdyM0OLOCRglIfgzPWsk6b5zDDIcbeNmiqr4l99QL+E7+InEPYprRfCerI2+xS
         2qaVIBLqZeR5kPHQvalISj6ClqG0EeAJ0qT7kYSqj0klYaednx6UfPsRaNEY2jmC0Ou9
         7czQQzGsTx6sOu8NKwQ9aQsAYTrNq0J3wFfom3SDjrCH2yhyp7rD90+56tpldb9Ax8eu
         1rJXuSqJCKFZ82ex/1fCTqffY2yF763xTtBrgVMGMcbbPxlF2dLftEbqFGO1mGM8LOfH
         l1dA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/RRZpCxG/n/8eQacoO+gimA5x9UcIAQpQmakeuU1gu3rwdD9oR6iNxfOZVnoS35vL6ab0FSheNSgdTdK5vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTZzIUZ6ORyqx0UhDZwWhlOpMEV9crYGaO3jDZ5jUe9gyq4y+
	cFRkj4TdCyPDTaUZ15O8sFrEZlDhU682b8QLV99C80HhxV5IOSL4y+2bUpBz0+8gXclP+GLRUJw
	cMtU2mXqpEQ==
X-Gm-Gg: ASbGnct/QxuCDkvVXlJwGTy6Cm3w9hQaz81PYN+rYqAjuQ6ZgZ/J/panf1wc9+/GS4K
	DmwyYtgLAya6Esg+3zPpTsJYtRn1aASy5dHLMDpqxQjr/npxYW/3evrEre2Ivh+NMUN1OpaI0up
	85DN8I4ArxMxCZus6UwIJCBEwhMu/WcRLeD/Is9pBNiwSCKu/Nw7VXjy7DnIQC1d24owaNFmMhr
	nJ4/QvCnrDVeJU4NxABP5TFh3w9jE0RvXn8x8KvL2C+yRMghsKHuRepCQWTjdlD6zQOhlQw7Zuz
	WoDhznk4ZyR7E6IGCp9jCW1x9dF1k6S1qvSusvQ3UHyDeYIa866Rf6VC8rN9YbUne3R9Drhg5h5
	47xfD1HDUTnjtpVXNt0+jJyVY4R1DFmS6XFhH+N09oQV6muTp5hq3vQXdgrBq2A1xnJ8PhJWrJG
	Eo+xWexxkKinwnLZMn/UdcrB/E9JdcmyAswZirzYHXqVDXStJk4nJKUJRimMJBklQyRg3TErE=
X-Google-Smtp-Source: AGHT+IHFXI6m0R05+uRKHt7y3gUYpfvnfaPtMBTE+pWKu9sa+nTw2xL/te7zdvb2+FFBl/Yi0qsZhQ==
X-Received: by 2002:a05:6402:1d55:b0:649:64d3:1559 with SMTP id 4fb4d7f45d1cf-64964d3196cmr415540a12.18.1765265572542;
        Mon, 08 Dec 2025 23:32:52 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b41219c1sm14140838a12.27.2025.12.08.23.32.52
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 23:32:52 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so9054215a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 23:32:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcX+5Fk9QTEwkxNf9tGCuAmxDBNE+UvzjZU9A/vAv1kIVdc4rXo4fvDN77DLvkYovfssZN1T/TAP78fdkHyKE=@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:643:883a:2668 with SMTP id
 4fb4d7f45d1cf-6491a430019mr7384754a12.21.1765265177527; Mon, 08 Dec 2025
 23:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com>
In-Reply-To: <20251208235528.3670800-1-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 16:26:00 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
X-Gm-Features: AQt7F2pU3mtSVlk8xXoOHi4ywQ2NpA8rkmyzrskk-X7c-Gbp__mUx8NnR72v7NM
Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 08:57, H. Peter Anvin <hpa@zytor.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git
>
> for you to fetch changes up to branch auto-type-for-6.19

Oh, and as I was going to merge this, I noticed it's not signed.

Let's not break our perfect recent record of using proper signed tags.
when I know you have a pgp key and I even have it on my keyring.

Please?

              Linus

