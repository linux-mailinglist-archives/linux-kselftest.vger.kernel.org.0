Return-Path: <linux-kselftest+bounces-41528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D90B58789
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 00:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAD01AA7521
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558137260A;
	Mon, 15 Sep 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kQiGC45J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C826AF3;
	Mon, 15 Sep 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975641; cv=none; b=ggzaCs2g+BBgOwfXHo0H0Ahk9ekp4OzzOH2E2jq2r4pfMEtuqGcnVusB+hcTjo0Ia0kYoCGySKcvmtwsirnlmWAm+rBvbd9zPErhAWGxMATZL3VyRD+iUfhmQo9B3y4rS8WsHEhzZfj9o8h2JxlAxsbMKAOMav8X622ar/KaF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975641; c=relaxed/simple;
	bh=4+j2ZwWw69a6PbffrzDHOXf9cpL/Ee1LRIVy4txUtZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AXknMsBFmzENX0ed6wVYVy8LP1ZptrrJPhjoh/E/tAjJpWPXAbO6zopyPxLFUUfMz1VfbhHQdnVIkh/YCdb4AWKWPA71xm2eQaxVso0kZ4ZCwd5pt3stZuISvKrGyFXLKV14W3THidUZgpvk3uTUuE9oRUJ6NbtRCmBxt18wtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kQiGC45J; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3671140AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757975633; bh=QmIdxnQAy5/6n2wVzqJZbhh0D7EAUnPeuQk7BYKKuBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kQiGC45Jj4zPN3+SDKLUz3VE3xbiYaBZRjcUA9tF1yR1GqYAb3CKdNtYUtLK7sssH
	 Y5O2dwB2bA/MZbXT7enkg010ih9TiqQRob4Lw3UgL4dNdZ83mZPUrxod4e9kfQwz+9
	 WT/x9g907sMya8UD3Yt2pzMhZ+7sJMVB9pfPiZXFKebC5IJ+r8PPOVlp/K29nSO/hs
	 ZMkjS7BAXCdpcE7UJIpK/UaAoZKl5QRbycKgJGdVUaXw0irVjUGv2pT0nwHI/Kp1dT
	 C+y8oYX9tK6kOl3WWl2/ZMk6OT7i9utbmvst4UPNMTacnIa/miHarEwYgmjhz3utMA
	 k6aFf/Y8k/STw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3671140AF9;
	Mon, 15 Sep 2025 22:33:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gabriele Paoloni <gpaoloni@redhat.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org, safety-architecture@lists.elisa.tech,
 acarmina@redhat.com, kstewart@linuxfoundation.org, chuckwolber@gmail.com,
 Gabriele Paoloni <gpaoloni@redhat.com>
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
In-Reply-To: <20250910170000.6475-2-gpaoloni@redhat.com>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <20250910170000.6475-2-gpaoloni@redhat.com>
Date: Mon, 15 Sep 2025 16:33:52 -0600
Message-ID: <878qifgxbj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Paoloni <gpaoloni@redhat.com> writes:

[Taking a quick look...]

> The Documentation/doc-guide/kernel-doc.rst chapter describes
> how to document the code using the kernel-doc format, however
> it does not specify the criteria to be followed for writing
> testable specifications; i.e. specifications that can be used
> to for the semantic description of low level requirements.
>
> This patch adds a guideline that defines criteria to formally
> describe developers=E2=80=99 intent at the function and subfunction
> level in the form of testable expectations.
>
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>
> Signed-off-by: Kate Stewart <kstewart@linuxfoundation.org>
> ---
>  .../doc-guide/code-specifications.rst         | 208 ++++++++++++++++++
>  Documentation/doc-guide/index.rst             |   1 +
>  2 files changed, 209 insertions(+)
>  create mode 100644 Documentation/doc-guide/code-specifications.rst
>
> diff --git a/Documentation/doc-guide/code-specifications.rst b/Documentat=
ion/doc-guide/code-specifications.rst
> new file mode 100644
> index 000000000000..dee1b4f089e1
> --- /dev/null
> +++ b/Documentation/doc-guide/code-specifications.rst
> @@ -0,0 +1,208 @@
> +.. title:: How-to write testable code specifications
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +How-to write testable code specifications
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +------------
> +The Documentation/doc-guide/kernel-doc.rst chapter describes how to docu=
ment the code using the kernel-doc format, however it does not specify the =
criteria to be followed for writing testable specifications; i.e. specifica=
tions that can be used to for the semantic description of low level require=
ments.

Please, for any future versions, stick to the 80-column limit; this is
especially important for text files that you want humans to read.

As a nit, you don't need to start by saying what other documents don't
do, just describe the purpose of *this* document.

More substantially ... I got a way into this document before realizing
that you were describing an addition to the format of kerneldoc
comments.  That would be good to make clear from the outset.

What I still don't really understand is what is the *purpose* of this
formalized text?  What will be consuming it?  You're asking for a fair
amount of effort to write and maintain these descriptions; what's in it
for the people who do that work?

How does an author determine whether the specifications they have
written are correct, both gramatically and semantically?

Thanks,

jon

