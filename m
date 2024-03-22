Return-Path: <linux-kselftest+bounces-6500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A2886F55
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 16:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745BEB24A16
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836124D137;
	Fri, 22 Mar 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COJyZ6FO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD94CE11
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Mar 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119633; cv=none; b=kLhxCLwbD7WG0f6knTMAmO3e+LV2EBgK8vNUP6w/1BylPHohDQY5Dm9FzgBVdK+WsQoXgtH55Spvwx4KyN97r5a8fpk5qF673hvUrWGadg5DUu75PaebH5yWxQ4AkrtgPY2SHf2eLduKyQ2TeSkWPq9mdOLwbx44ZjOCPXUIB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119633; c=relaxed/simple;
	bh=qXdtNxvPpsbpNODgvKjpT5XrGKp9Pc9HMJY7AIX1h3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba20DkNDH5tWJNrxQSLvq9+w2DR8Fkqf514Q9PcSpm77fA2oxq1r528pnI+SX9j/g36AvQa6MhWyL6roqW91dGrtb0sKzpXtifk75Tq+28B3RE5o9HyDNAScdLBKrcdU7R9y95Py56cRotEPpiUYWxa5nqEqh0/TfZypzKlhVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COJyZ6FO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711119629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ot97iwVakR2lkEIdq7JcwHUhieIrzYpSO8j17uVWGlI=;
	b=COJyZ6FOuIon+FQ+E1/FTPUqOdGYH+sEhw22jkTQm1NQsin4/kWhth9vzH43gEyFHRwedd
	i2Wtv6yxtCxzyjLYwhswrl99GEBaupdBX0SW/tGBlm3tDreu7y6yp4qWRCXwoveUPXah1x
	nHWLwBX7MhBLD68vX8WxpILHJJXT7ps=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-DFyB2n_kPpeh9gtsQ-NLIg-1; Fri, 22 Mar 2024 11:00:26 -0400
X-MC-Unique: DFyB2n_kPpeh9gtsQ-NLIg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513e0c5f399so1898151e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Mar 2024 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119624; x=1711724424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot97iwVakR2lkEIdq7JcwHUhieIrzYpSO8j17uVWGlI=;
        b=ENtTbbdtqetCA0ysPj6PJZKpruxJn/1PL6YFTw1W+7FnT4LSI+6H/N1ZPPzV0JGEAp
         UZwCwUBMPuhqo5FNlZyWjAHZrK4j+AA07uRZqE4Fo9ib3UFAAbxywwoZYyR0DGi8Nk7O
         KEiRdVQ0OmYLgr1ZXPRCgpuFqGk1ztRqwRPGLkX1N6xVTRXiVWNoniftz58RuJ9YzOY5
         BfNEkxv0hc8uePjXKiyRmyMiP4sG4SeVIy8SL5Myrzl4v/KK+5hmkRAvMW07+g9/KnzK
         y/rJDza4Bg9H3F4v7YrjPcWNOs6DMJUVix3xMPdbd8ddVcW63DG5lKmLMzy+9eAKntYa
         OY4w==
X-Forwarded-Encrypted: i=1; AJvYcCVb9qEClqZD61zK4RTZ8z80izSnJdtlVF0yuwXUCfJtBgYgH5tCE+LmR77LMXW9u+14MaOP4qT894oMTaDLn1n4pFH9HxlVJoEYTsnsvD1P
X-Gm-Message-State: AOJu0YyhxI3d6cJR6m/hGN7445WTBzwMN8pK57dvFHC4W0UfWj25gIGD
	AN4q3rO8qyUDL2CfEd8fmlYsE9C99tWI0lAcm4NgZPxD3ZVSglxQBhb7TbZdLx/M/A/wDnvvkD8
	JuehuhDm3kehKwfrU+wN7ZvIbxZymv4MlYlpnqCcCpQgW26Wi5rJW0k2fgKWitp6cqRGFKLkwaA
	R4ErQPKUXsZ6GH1pjFINJUFv5uyQIKdkEFB9bSI9et
X-Received: by 2002:a05:6512:612:b0:515:9ae2:93b0 with SMTP id b18-20020a056512061200b005159ae293b0mr1451120lfe.19.1711119624754;
        Fri, 22 Mar 2024 08:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoRqFuVFSCcYFtb/4CXLayeI15qnsRqHHZP3UDWQYikqtlTHVTRgMB97SI5tl1UUWqtCQprd6t9b/Lw0uFLEw=
X-Received: by 2002:a05:6512:612:b0:515:9ae2:93b0 with SMTP id
 b18-20020a056512061200b005159ae293b0mr1451109lfe.19.1711119624396; Fri, 22
 Mar 2024 08:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
 <20240315-b4-hid-bpf-new-funcs-v4-2-079c282469d3@kernel.org> <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
In-Reply-To: <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 22 Mar 2024 16:00:12 +0100
Message-ID: <CAO-hwJLgx=vndgMRW=f-Gy_36CJLqwAzOoELbckvBn8NvCJB6g@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] HID: bpf: export hid_hw_output_report as a BPF kfunc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:06=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 3/15/24 07:44, Benjamin Tissoires wrote:
> > +/**
> > + * hid_bpf_hw_output_report - Send an output report to a HID device
> > + *
> > + * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_=
context()
> > + * @buf: a %PTR_TO_MEM buffer
> > + * @buf__sz: the size of the data to transfer
> > + *
> > + * @returns the number of bytes transferred on success, a negative err=
or code otherwise.
> > + */
>
> Minimum change:
>
>       @returns:
>
> Preferred change:
>
>       Returns:
>
> "@returns" is not documented.

Thanks for the doc review (and in 5/7).

FWIW, I'm still waiting for other reviews if any, and if there are
none, I'll just amend the commit before pushing.

Cheers,
Benjamin

>
>
> Thanks.
> --
> #Randy
>


