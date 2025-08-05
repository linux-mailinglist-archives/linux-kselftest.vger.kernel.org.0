Return-Path: <linux-kselftest+bounces-38306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B792B1B8D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 18:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2603ACE35
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E4292908;
	Tue,  5 Aug 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1UIN4ta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CA25A631
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412720; cv=none; b=IVU4nuqxIAm8dhefgmWRlK7lW5lzm+MKWZZjDX5xKrOHGhSZJPc1lbDg6Y+V8065mhEv+F+hUlhXLBbUFbUZTGA3fXFoU/r+JbSJrufG5ZGjC+qc8DjxVO+ZAGKXr3/Dtt52h/sYRWXiluvHg777FrHvrDFfqidVdpPuGHEmgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412720; c=relaxed/simple;
	bh=TtQz9oZBcUxEy3cvbREKfQnFEd4wyNFsn45a039ZSW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfifFF2MrUn+oXJQ46iO9Jjm7jnzpXb017GovU+oHGKFX7trNa5VRkRnffEHQ1dvEoSRvgcTuu8oMowce37S4qtbRzX1LuXUsSlM+RMv3XdsgPeoFqtDB5rkYwpnhqa/3E8mMm6KGGyKz9rYdhAz+7CNlVE6ykgHceMFOg2HLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1UIN4ta; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so3036104f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754412717; x=1755017517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdp2THZ+E1qrWvs/TZoDbRRKtgHUJqw+d2seDNABwpY=;
        b=H1UIN4taqdSD/MbvAOsX7xQ53g4YfIVi88bDBVbvVx1VLO0tE7HGOc0rVybZYljAB1
         wb9kUnNlP0E02irXTKZjxH7dWQt65vGxzFYF+GX4ZDrDLSY6zF4UPBqHeeR0IJrG0oWt
         Q/KsLloTjQxmW492ypsNBcPJoCWbJtRcDI+SEB/tSMoL0OB4hRHQajfTb7pvt5H00YTR
         DDsT0xoG7ZKezVqfPHonW8NzAf5yYNoA4lLByMTZCITDKGTqR0E0I8e/mCn6dGG+K3nk
         RZDWTsUNbeh4hQzDvxmgEGc5BCg2WmdRNOTXxIV6Bh0rJpSHxPJYC3VbNT4Zxd+F5kaW
         XdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412717; x=1755017517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdp2THZ+E1qrWvs/TZoDbRRKtgHUJqw+d2seDNABwpY=;
        b=FUlrqCexG80PZVwqcUjPPP+67AsOpYCZS2lDoAIO6v7oWkjGhDZuD4IyBzp1QBhKQb
         JK6uudTsDVVv94+64OmbTf6skkUZKUaJfyrAkbEKmknr6mulJXSevw6//iK/dZvyovnt
         AS2NnNhleV5oCosrldUShRRn/JCxd/tNZje+eJB5SD5pk0rvMEJnwxrOPGZKOAMFdnTQ
         ZWqg5BvGVYjVpZrI6FrAUT2eKnXzp2z1aYhg2Unq0+SSxRjTpTPZHCTKO7RtzCtngDwj
         HHP3nrLq5A23dTyTNKtNMcF7hYRK5GJ/U51Fls19XTRS+6lTj85PZcFO9mV3ScY23ra0
         Idtw==
X-Gm-Message-State: AOJu0YzundULCE8lP8cj10is7be129USZ67vBWW4wqtbxyqH+5mgknU7
	5QpmT2TUhFOW90iZNxd/frGyOnZ84ELdx1XZRj2Ciy2eye6R/N7DHnbjjkZ7arhixBOzawCr4h1
	9SdQqAyZ6jTULBmL1AGTeNqzUCNbpyVQiFUnjRabL
X-Gm-Gg: ASbGncvxAb32gkx1+U4DYaK596KGE/KKilcgEsSx0oJLt5bqSaQ790c1CLa02Y6feFe
	rzLFZOX6pkE4a/veXOh5/lYOttFNh4Xv30kB0jreRcEHwV8MNNW+NmFvy94GtIOVZ2pv/YPXqVU
	qE1CN2zyh0GK94vEq5aroOYKTavzAjRjTQyreowMsLKmvLPFfz0eNh+7xSnm2aD6XSJHxz138ZJ
	4BQ3lxC
X-Google-Smtp-Source: AGHT+IGCJi6AAfzPaIlWNF5t//K43GKbKBI8wrg/kqvHP0TtvUzS781NSDVS2jaYJIrQrznLTHRuQGhHzTOhedemSVQ=
X-Received: by 2002:a05:6000:18a6:b0:3b8:f356:a2a9 with SMTP id
 ffacd0b85a97d-3b8f356a2demr395048f8f.46.1754412716960; Tue, 05 Aug 2025
 09:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805013629.47629-1-sudarsanm@google.com> <24bbd9df-efa7-4090-a696-1eb40904ad85@redhat.com>
In-Reply-To: <24bbd9df-efa7-4090-a696-1eb40904ad85@redhat.com>
From: Sudarsan Mahendran <sudarsanm@google.com>
Date: Tue, 5 Aug 2025 09:51:19 -0700
X-Gm-Features: Ac12FXxbwVDLUIinZ5AcPHR32UCRbFB-2WNiOt5M-pCIiVirC4bpkJyI48QVUN0
Message-ID: <CAA9mObD9zr8Y8Z4F7OZGi_NiPfSZxUu3gKNWPQYRAeBFQBO=SQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/mm: pass filename as input param to
 VM_PFNMAP tests
To: David Hildenbrand <david@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks David for your insightful review comments.


On Tue, Aug 5, 2025 at 1:47=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.08.25 03:36, Sudarsan Mahendran wrote:
> > Enable these tests to be run on other pfnmap'ed memory like
> > NVIDIA's EGM.
> >
> > Add '--' as a separator to pass in file path. This allows
> > passing of cmd line arguments to kselftest_harness.
> > Use '/dev/mem' as default filename.
> >
> > Existing test passes:
> >       pfnmap
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       # PASSED: 6 / 6 tests passed.
> >       # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass params to kselftest_harness:
> >       pfnmap -r pfnmap:mremap_fixed
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.mremap_fixed ...
> >       #            OK  pfnmap.mremap_fixed
> >       ok 1 pfnmap.mremap_fixed
> >       # PASSED: 1 / 1 tests passed.
> >       # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass non-existent file name as input:
> >       pfnmap -- /dev/blah
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Cannot open '/dev/blah'
> >
> > Pass non pfnmap'ed file as input:
> >       pfnmap -r pfnmap.madvise_disallowed -- randfile.txt
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Invalid file: 'randfile.txt'. Not pfnmap'ed
> >
> > Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
> > ---
>
> Thanks!
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

