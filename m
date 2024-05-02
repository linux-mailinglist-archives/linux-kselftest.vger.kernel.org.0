Return-Path: <linux-kselftest+bounces-9288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D38BA231
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B441C21E13
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47734181CF9;
	Thu,  2 May 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F876ssa/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE6181318
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685051; cv=none; b=EbQDMjBaFhdyx74XTV/mPjx2TJPuBXwOVpUv86AlHiil+8uAu4OqxNBN862rwvDZUAxshC6Of2l+FxCSVLfeQN1HwnuQ5IXd51weXwSCDR8Ac1AYkhDa3gLCyYRlXxttOgp8HK1quEEIj7fhGyVdrPAhzwOd42CHcNBVJIHE/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685051; c=relaxed/simple;
	bh=e5MnDYpDbG4HN+rm3kIwAqZE0h1MjgBoqyIP17amCKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSrIEVBpo6Pn2dINF6h0MErgq3Xd88gkaDEiukg8cEnfKhqGk+21CQMlw5FMN41nj4Q5Wlr8IoPpDmvLU5AzXaEOTYCQgqxP/jFVecBDmpEExo4wQ9zJBagVaOMqJRy7Wr3gPVjLCDfLg7MIgl91PsHII4XWwcAbGrSh1esuHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F876ssa/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso1917a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685047; x=1715289847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DpXkrfXRsTHCLm8mx8p2ZuP05XHl7UCwnC21b1+Ido=;
        b=F876ssa/nc3uQtcmX5bNxOK5roXvQniRl1J7VAAMoVr1RTWoVzzlY+QLdagqt/Owjm
         bjdFFb2oLb1xjsFqlE/xelE0VUIQQ9W3loacGrAnIXG0npf2cfw1Y18ibGRiRjyf+ij/
         ROMJsbfl6+lMRoUhW1XI1guwDIiaMPg3fl2JMDaPjqW7KyeLiUOYPqiouD6sgoZiscnr
         gjaUfldWLkewmF69R9A96mAJAVLm/2b3LTsrUtGfK/yfjcW+Th4fqDC1ibJJGted9lW/
         hcClyU9xC3oU1v5N3YtwWJmoIgz9hov7m8/kIuhq9iPdVUQ7nMKk/+KXWmRNrVLf5XW7
         q/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685047; x=1715289847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DpXkrfXRsTHCLm8mx8p2ZuP05XHl7UCwnC21b1+Ido=;
        b=Y2ohbj/tCYJ1qB64vZBY85bRHcI2ps4WSLlbXdiCr1lqipdFCBLytJ9e55OTmCsxue
         6DtWP5K53W9pX+cb3IGRsyUNAQm+9pEC9aZPTFpXPOyswenqOoieeIcY8Uamjysvmgx1
         kuKW5yTF2JixptB2i/eKbFLyaguOLK6y+MHZcWXcZvPATNQr0d1+wRuO+kY+sSkK4IOA
         eLVAZX9l76rHlIxynvw3JdVX69bW/4TCWplkGpjzgbvWH8npqdYauAUxTl/vpXwIamtx
         eIToKKI4CGf3y15L5QzLCdaW6CU6VvbkF/0IYh55niCBwCQiN7Go6REelPGPPJKl/7Gz
         Pp0g==
X-Forwarded-Encrypted: i=1; AJvYcCWw/gDrc287ql8yXpaq+P+vwVtzQfKiShrTiB5WHeGfxWGUn7e2FWv+E1wBT+6tfIn24v5Nj1TuNOI4seDu1IDODTulZsFM1RlKmCiTpvZs
X-Gm-Message-State: AOJu0YzHPeiCT0ikFRQ218T8imtZq5a68LS+g1RfCCQA2gUsC8BxLh6K
	Qwp/Mah0cQutOaUdfOq1B7baXcsWPTE3xfkW4esjzhS4SbgYbvjWaRV3HBR6Zh23U2kW7GKEeLb
	XN4vBB7lDxzjwCz3DC7Q/vYlz++rClta3iFdn
X-Google-Smtp-Source: AGHT+IE6D0fEqWY7DDB8CwkPwGyVRibjt+oC+Eg4cUWkVc6Psi/KvL45XqFWzXhHNui+xz3wqXew4hVko87URKKdZHA=
X-Received: by 2002:a50:999a:0:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-572d0f4be13mr12509a12.3.1714685046627; Thu, 02 May 2024
 14:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-4-sboyd@kernel.org>
 <CABVgOSnEQ0m_nG-dSA3e+5PSazh9uTB_A56zRrphh5vgPsYk3Q@mail.gmail.com>
In-Reply-To: <CABVgOSnEQ0m_nG-dSA3e+5PSazh9uTB_A56zRrphh5vgPsYk3Q@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2024 17:23:52 -0400
Message-ID: <CAFd5g47jEkDvxkg4Kk066_RgN1w6AdjtCKSs3=shWG-kXynPKQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: test: Add KUnit empty node binding
To: David Gow <davidgow@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 3:55=E2=80=AFAM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Describe a binding for an empty device node used by KUnit tests to
> > confirm overlays load properly.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>
> Looks good to me.
>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

>
> -- David
>
> >  .../devicetree/bindings/test/test,empty.yaml  | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/test/test,empty.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/test/test,empty.yaml b/D=
ocumentation/devicetree/bindings/test/test,empty.yaml
> > new file mode 100644
> > index 000000000000..20dc83b15bbf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/test/test,empty.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/test/test,empty.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Empty node
> > +
> > +maintainers:
> > +  - David Gow <davidgow@google.com>
> > +  - Brendan Higgins <brendanhiggins@google.com>
>
> Brendan: Do you want to use your linux.dev address here?

Ah, thanks for pointing that out, David. Yes, please use "Brendan
Higgins <brendan.higgins@linux.dev>" here.

Otherwise it looks good to me.

