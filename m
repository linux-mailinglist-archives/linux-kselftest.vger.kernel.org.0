Return-Path: <linux-kselftest+bounces-34206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961EACC44A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C0E170507
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA222333B;
	Tue,  3 Jun 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvlTS3sl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2C21C177;
	Tue,  3 Jun 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946516; cv=none; b=Hpa2vfzFcMfAUsjD9YJb8X5N7BUeyCGBfXziqvy90ENYj1sHv4ShDuRyaNNs0idArbxfHtvuA8ZBppvhTOOUwQw7AogF2q68Y+ZtscJFBPupwe5lZdbHyuoZC6wNuFzVcC0dNHtRvFbaiCm17KWZqr9eHsU20T81t7nNncVPL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946516; c=relaxed/simple;
	bh=23ShOGSo7SmmzbIDnNs/ih+q8VmQpKuIWu1ZnoFocz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEHdLe4WsAY0F+ys8Iu8qu7NQBq++L0DdRS6JkAwcXBqc4DRxHQGJiWojAvANsHec7DO2c2PFQYIRKv8RLFy9ttU8LKoAqzxDJUoK355qXH8BBASncPyGisokLJ7APNJaUW3NVXSbjo3JTk2Hi9npUfSirhUtQ2PFB2hsmW1y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvlTS3sl; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-606477d77easo3178041eaf.1;
        Tue, 03 Jun 2025 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748946513; x=1749551313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjl0/MR/LbmXztwG4PJPakxZYI1EygtglW0+NwZ37aI=;
        b=hvlTS3slrnDtiX8vKO5zskWEwbJY/qo/wH+zMNthOwbg4iCm7KYw2D0oHEpPXXlPu7
         QskKmTMZENqzGIpECVYZpZTjymEmbzc6u0hOmQby0NfyMUZdZ9UvBRO45XTmV2UjQlvg
         qx9WT0/L03tTyYTgHVVVR55b/uyImYbsAbfndqemjnBlLVzjXQaHsD1zMkFKjPE3z0CJ
         fAUmt3gv/vaxIEgNKpYV/qbWqg5CVFckNS5w3GdPRsJojbd8RNqZnaJ+hNjQMsdT4G8y
         97FpupPE1w6ooRjmDuCaefQ63NEFZAsKCAo4IIlINxGBrQD072S5zAHENg8UPAGKc94Q
         XzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946513; x=1749551313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjl0/MR/LbmXztwG4PJPakxZYI1EygtglW0+NwZ37aI=;
        b=O6m88wNJ56bCX3EKf02FJgXLEjrUS0vUYi0mUu7vhXtylffkie94n1pzNrdD3K3FWP
         8ZnCwMGRPI2bB0aXTUcNWsnpbh7QpfdOx0DAv6w0Ak9UFMNqtl+ufOvDSseUNvhdpVRV
         4XXakkufLWkQRH1y4gYUFhdwkSVUMRvW+q1oyDRlmgNaTQcPJDZD5T/nFsXPzuQzilML
         YBZ5nQB3Q38VNNwDuB6m8XV3lQrst8kb38Q3WgcVAa99Nnk6s7rZ19OADOFZVwN0GqmT
         k3yNq+c1mGJLJsz6uDcigxRG+5LoJMDdL6Ze4jPaoXFztBKrJzZQr13XLdSlVOvn9UFw
         jV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXoOXbLtQZwNT81HFXBwxaNkPYXU73455Se8HVU4fegrAG9eQCP++YQMHlhtFQ/rVlxosgJGnJYzSUNgr46ZwG@vger.kernel.org, AJvYcCXBP6diErjU9RLIrymie3Y8JEgWP3+VpERV8lKyCO2DbL941HDPQMB/g9K6X8dYcuItpK/Doiceb8Fftc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Mrc5MsbdZ3Gtt2OcVu+PbmXc7SMfpLc1jkYSM6MS6BwyLSGs
	NpUofEZlgnlq87IJqglZ9OKQgkhVowLEnN8yIURLbJlMuf8y5i2MQfWteiQpqqphv9RTNdJkBJY
	0koNPoILrHF1Ja++9AbV+aa2luHgkap4=
X-Gm-Gg: ASbGnctnnti4wX7hItVpK8gTsfghvGH7wW0RJ0BXMk851ZS3L5D6T9fFmX/0SjVVvYT
	9JaYWl9+jn5tiZGKpzWu7Ef0spZbdIOJ2fhWGdhRsMw/mNcYCzQGxamN1XVQwlAxH6kwpi018mY
	iqJP+IL8OsOTUE0cjBYOrGJMonSXTAq/KjglVoYNgzf04p+SIc7O28IX7BhAbCQEEWqDA=
X-Google-Smtp-Source: AGHT+IGehz0pplNAnK9ZijKBUuiZF+ogbbTTsccK99IRbmEXSOsAqOAfWRxVvhz2B8goO+2yfuOx4EyzXhyG7yqtZ18=
X-Received: by 2002:a05:6820:c04:b0:60b:cd42:7a0c with SMTP id
 006d021491bc7-60efdd48335mr748935eaf.3.1748946513397; Tue, 03 Jun 2025
 03:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531070140.24287-1-sef1548@gmail.com> <53586971-e67c-4b10-b42c-4aec8fc4fff7@linuxfoundation.org>
In-Reply-To: <53586971-e67c-4b10-b42c-4aec8fc4fff7@linuxfoundation.org>
From: nick Huang <sef1548@gmail.com>
Date: Tue, 3 Jun 2025 18:28:21 +0800
X-Gm-Features: AX0GCFvTQCAGIpsAV4rva6pAOGFAWYVx8OzKEMELWIGJuQTUkrX50pox5qfjJSs
Message-ID: <CABZAGRFzntrDSvO4C+LG=GM0ot=X-pBPWKn1K6JYd=9X=X=8qg@mail.gmail.com>
Subject: Re: [PATCH] selftests: ipc: Replace fail print statements with ksft_test_result_fail
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	usama.anjum@collabora.com, zhangjiao2@cmss.chinamobile.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for taking the time to review this.

Best regards,
Nick

Shuah Khan <skhan@linuxfoundation.org> =E6=96=BC 2025=E5=B9=B46=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=886:17=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 5/31/25 01:01, Nick Huang wrote:
> > Use the standard kselftest failure report function to ensure consistent
> > test output formatting. This improves readability and integration with
> > automated test frameworks.
> >
> > Signed-off-by: Nick Huang <sef1548@gmail.com>
> > ---
> >   tools/testing/selftests/ipc/msgque.c | 47 ++++++++++++++-------------=
-
> >   1 file changed, 23 insertions(+), 24 deletions(-)
> >
>
> Looks good to me. I will apply this after merge window closes.
>
> thanks,
> -- Shuah

