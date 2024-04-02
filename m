Return-Path: <linux-kselftest+bounces-7004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC22D895B85
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 20:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9A2B2210F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DC15AD85;
	Tue,  2 Apr 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrrTfE5e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA515AAD3
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081706; cv=none; b=AjCBPuXUhnkMAkLl8GXC8nPFVsiUzgObxyZ6e/fRIMX+vzDY7RtItTnB5O3A3hgsNm+VvFknNAlhhHLM9M3+hynVT6LhdR1jrY6X3A4cp8rMOt+NPsAAp3izD6cmmXkm1boOvxfDTQV9GEMmde6pdxvGiR+tqLIo23AKyNs8tWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081706; c=relaxed/simple;
	bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4kRUM+fFLp0mUssnV+LYbEBNUe4CzMMWP1hJNeBkFh5AOOz/k81YBtmd63OMUQ4t65rhqKg0Tcf113oPXRq3GSB6JBP6LhPP5qB5KwSEsAYddhxZtvtHGW6tonh8tLJsbC0l5THzKkxsy4bk7iRzWBqUxlrWiMSSqjfgkVa4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrrTfE5e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so213454a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712081703; x=1712686503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
        b=QrrTfE5eHT9Ks7P91fL9DWFfHfSPMbXGPLy61CxZpOMOXgBWxr6K9tzWe7KV1LXtIL
         udB6dXq7MEVactyVz7QR1KUUbajVJ+MjxUDGIw51tVRm6QDeSG7+V04e/rkmQFJfu+cC
         po/iuhj8u9lncJwajFBU46fPI5Rc/XtxZamDbI1cHO4RinWnQJ/TFgiNtFEnKhdw0dXz
         YPeHgAwj8QB41RsA0p1iprvkWLRrtQdI6Z56jNtRs2YZXNj+e7AGtswL08ODqeYamH8T
         Xl6oz2QuH0fGXg2NhozatSLqwzp2v3nCEyi/UTXQ4QIMmgBYkd4fi8k6XBioVPldu+F6
         aYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081703; x=1712686503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
        b=ARgEVJ6zmFCOrOQO9XaRgF7gFlyA2ErQUvv7IZOJaJrBgUzaXDvI7YKHoVSKXXtrqG
         iAW0qG9S9hoilqI6FvtGHZpQ0fAEw8CcND9fabjpGTU2hbya2yKa0f/0Yh2BwLeSeszx
         F5oB3Qatc5DOLrXrr/bOKHmCdkNl+YQlHiN+Bg4OZ9rR613Vp/TD1ZMKKoZXs9FftW5l
         MOkWRp5u2jgPkJJmVUoR0ivQ1UsTgJ/54aFd6cjTadzNxdeLOWUYwwyqbpdXX6AfETxq
         6fldzzTpJ+kNWX0KmPzL0qP/LzcFrhz5Rby1qc1xoamUEk+2XkF/EMQXnLuLTjOcSyUL
         piXw==
X-Gm-Message-State: AOJu0YzbgIra5vzlORhVtTC5jr4hiIh7IHtUYXHWscrTFOP0MRxYcl+c
	vqJthfA7FkQGHCeEf7Gfa2aaRI6cLJQmB66l9PiIXb5Lc2WmPrWC0PJL/j4QdGSyBP5JIcLtqyf
	Z5kwHyu2RN/vtSXn/NLQXa35a1d949fvSAB3O
X-Google-Smtp-Source: AGHT+IHP5t0nrM9tmIdN/vj1cEcR9X51TIZOinjwJqg520IJ7wC6cLJyegvw1MPl9rlRhm9Xs3DTLyD/c/Q7svlAuPk=
X-Received: by 2002:a17:906:488:b0:a4e:1d5f:73ae with SMTP id
 f8-20020a170906048800b00a4e1d5f73aemr216379eja.12.1712081703092; Tue, 02 Apr
 2024 11:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com> <20240329191907.1808635-2-jrife@google.com>
 <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
In-Reply-To: <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Tue, 2 Apr 2024 11:14:45 -0700
Message-ID: <CADKFtnScmu+57KURFEUG5s8Qcx6NfAgF1XNfjT+fSZNLqV4amQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce sock_addr_testmod
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Martin and Andrii,

> This function can be made as a new kfunc in bpf_testmod.c. The
> sock_create_kern() could be moved to here also. Take a look at the
> register_btf_kfunc_id_set() usage in bpf_testmod.c and how those registered
> kfunc(s) can be called by the bpf prog in progs/*.

Thanks for the feedback. I will explore this approach and see if I can
get rid of the additional test module.

-Jordan

