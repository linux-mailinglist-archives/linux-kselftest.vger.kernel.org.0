Return-Path: <linux-kselftest+bounces-29705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC92A6E5C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210F6171586
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF661DB128;
	Mon, 24 Mar 2025 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZn14Vis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B22EC4;
	Mon, 24 Mar 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852177; cv=none; b=k3L7RDBGXn/lUD9d0bNjh+SF5dk+xFKOvRwNdegvmOUm4hN9s0wpEQap+R/kWI/ICFymvhHPy0GxNcFxiicIHzbl/813ptSL0TsZtfzU8czSvF83KafJcgw1Ninv1CJdyE10B7rbcul5/2JUZ+yY4QG51RLr2f4yefvw4mMD/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852177; c=relaxed/simple;
	bh=o7Q0kV8QS0msle1dp605WnKLnX1E3ZdwuBJ04427USw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koizRs9dwzFbRzcPz0U1+YVPxTssCDAe0dfncBOQmW14L3npnDkWbYW1TW6kMdsVg3cClxe3hBVcFch4z7CUuzOhvXzVyNDAK9jXpAUeN2fL2HNkW/0CJaKbvrHjZDlweVrSCKPBhpMocHcYR5gXgXBpCsyfMqerEPzLmiH/FnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZn14Vis; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bae572157so47290101fa.3;
        Mon, 24 Mar 2025 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852174; x=1743456974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afOB6ag896mBIkBbzUQRSaH8j8s6RPc/pYnJ/iv7sLE=;
        b=LZn14VisLw+M39Ug1D23c1gMe9Pc4K9UUnLVhpr8w0PnZLN9cHQ2eDzv9aMfk6gWQD
         bhbr40y23f5NcFg50qknlX8qDYxZvvTfGXwZItRZUtIR7WqcMka36/bO41ySvWqeRoWU
         wFKFpMk2fUdEzfOVAyfebgjkf8YWncZXFpmfplK9NEgfrqP79Ss16yiSKU3Tu8Js1hsB
         0KMRRuaHQ2ItGY2wEeOPQwsGnqQC9uoP1626gMPvaVkW+7aJ5hUCUkBT6/2FsgLiIYGa
         DU50lZMkBe8IoD+M6FwSe2YB1nYW/z4jSyoOmkQeeAifT1/YcY2gwiApFsmx5LitSAMu
         mCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852174; x=1743456974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afOB6ag896mBIkBbzUQRSaH8j8s6RPc/pYnJ/iv7sLE=;
        b=oM5nrJczz9rP8rbvk0Rim2jNEzMrFlUFa+BkmNV6GlWkzqmyL1k36ePBGM1C0D8n81
         IxYMVGntxetlBKsho41+t2dt5bS10ZwvToP/JDaqlrmqZQG+RHDqeqV2rUyqa9BrmneG
         t94eGp95qcm/xfjew5rP8CLMDSNJhTPjDmrvSEw4oF+tQcjS6fa7cRNymkrTCZ+JFlbX
         RNx+Ko8DW9lOao0sAQTdn5C/4RrKf7DNerLBz7JHoEkYiin/QqrqrOGDIJzgz3kfRvPN
         pZAdhtG+LN5Li8MEHUyun8rJAR8ga0aHcsMDCfGZNdQqzrTWiaKyDpMYFmgWh28PDt9w
         Pt1w==
X-Forwarded-Encrypted: i=1; AJvYcCUK+8xoEjdrd/82KK07fXhevEr4/UeMz6JXUQlJVo6ubPWuXmzz50GPHujYY9+ZXHLG3xH9RaTADTNoUAiv@vger.kernel.org, AJvYcCUmus/9b2EqmOClPtUmlXPKEHDzN4Km3Ki9j4N1vv9u79zDIkEIi/cYZ43G5o+tJOocEtlfn/tVanDc@vger.kernel.org, AJvYcCVggRfUFWAxJz8eL/WIYdyG6qhPXhuodR7KJDpGG00UKoK5X1CRtNzFWJgZSMH0TchD4mdy0PbPgZtF@vger.kernel.org, AJvYcCVte5hML0hF0rocYxAyRz8WtXivktYGVUETonSV5EOiHueFK7AAFzsCXTfcIc25dQSyvYal4k4f+Ilmz7Fpls8=@vger.kernel.org, AJvYcCW/Zk2IOVTY/XxE3QPq+KNB1UcS7LiEGgxlUaqwxAbKmSLMNvioy3bB6M7GIhejwbwqkzni6UfOrJEs2JaI@vger.kernel.org, AJvYcCW/deGSlVQGimhOegxB90dpsDvHfrdosNyFs6GAYKFhVGWl85h4p1vxFdEeABBiFt4WiBVWqhoOcIs++Nx5eYBD@vger.kernel.org, AJvYcCXC5YQFH+k4vnOQk0ct4h3OMGxQFhYGg8sbpJ23iLadQm3G7oJ1ooJWjiI/pH6kHHyDPG4NBYK2e8Rk6BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC28GUfN7O4QB/U6HxKEnaFEGTv25HyrY+Tpih9cbeDEExYm8I
	9H4o/62o7LCrEQbY3YdTCo6bMrfXeCncdB8qsO/Xm9f6+7rHkCRzJqA10W/CYkepO+dUxlVfzx5
	cVWUFHe6W/0Mnbt2ONJoNo3KGnFI=
X-Gm-Gg: ASbGncs7IQ4aTBpTBuL/cE25xe5tSrTyJtVVg+gY84x48UEtMeu1XOkhnFKDSK8NvRi
	YxY9EZ14sPmb13903KG2AqD+u69791jhkjHTpN9Lc5VwUBweeJ/+W/Xmt/dCbIWIsDIsQJH6nTH
	ouB3U1IT8I0/aySxvIJ9FY4kAFiujpMB9Qma5jvS4jpA==
X-Google-Smtp-Source: AGHT+IHN2CdMZmHfZroe1FQ4MKG8B/iM+YZc2LJEuBJ3glSuGFqE4mIhaXx3C8bz1hIuxly/9AUD9inoWHmnM0IfKeE=
X-Received: by 2002:a2e:be0b:0:b0:30b:f274:d1e2 with SMTP id
 38308e7fff4ca-30d7e206838mr57419701fa.1.1742852173594; Mon, 24 Mar 2025
 14:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:35:37 -0400
X-Gm-Features: AQ5f1Joz72-6GnRL9vKDP11rH-x8EIVv2Zut0eZx4s38DRCAalZYBl8bpmZl8ew
Message-ID: <CAJ-ks9k=ZcfpXo-SBj7TXRcc=2wbth1pqj4NN5AxUVU5Z4DwQw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
>
> > * some pointer casts in rust/kernel/list/impl_list_item_mod.rs:{253,254=
}
> >   not sure if they can be converted though (maybe they are unsizing the
> >   pointer?)
>
> I have a local series that gets rid of these by doing similar things
> to https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail=
.com/.
> I can send it later this week but it probably can't land until Alice
> is back from vacation; she was the author of this code.

https://lore.kernel.org/all/20250324-list-no-offset-v1-0-afd2b7fc442a@gmail=
.com/

