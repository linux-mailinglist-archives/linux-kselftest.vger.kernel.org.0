Return-Path: <linux-kselftest+bounces-31177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70697A93CD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15503BD41F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071EC2248B9;
	Fri, 18 Apr 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTkfKw4e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF591C5F2C;
	Fri, 18 Apr 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001180; cv=none; b=boDnlNv+Yi5QbEuOVIes93DBzsLnInucxe/hF6QJ9a+ljmb3g6lM6uoWpOV9UmoGDgUNFZdOat3jD1u0QgHfmAmXvxzCa4I+HkoaDGLh24UUNPic1XVIt4sbiOp2tgJje0KFH76wp2i8N7vv69xHtyZTLMYDFXSgukmpiUp3Heg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001180; c=relaxed/simple;
	bh=ou5tcv9JxiL2u1j3f5J7z0CBvUbEeh6Xv6UWW41q/Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIKGvnzxPoBsNSjHGV7G/i5tIHPHR6XzM0SRVp8mU2ReJjuX74SQDJE/fVYLmQU8vUswxRfxZO9ekltSaDgzF4IhHnKpiLMnzD4ZzyAz7uGnmeBp4Ug8Oe5BFCzhmYcbptKDMBG5W3rQ089BBi5FVewIBDIO0qZ8nftemLsRoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTkfKw4e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227e29b6c55so3339165ad.1;
        Fri, 18 Apr 2025 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745001179; x=1745605979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFANXjtKTfEx9kV/YD0moYxXkPIgDxsA41WYPtohNLk=;
        b=DTkfKw4etkWpNh+RFUp8WY1PgivSEv9PZw17qp44dcaCOl3v7OYsw2IPxNSuD7N2k+
         eWGOXbUuIfoYl9XNNNmKnxQrbqmTPXrOK7lnf0rj40wSQjandtGCbllalR1idb5xZbFR
         YkwW5YQDYzdTcAcd/RaF++/VlPVZVtWmx78DZW2Cpp4DBCe6PTPDcY48KN3DDg6qmM12
         4iayocZ2eJFMo0DOl78m97Mm8F1g6lv3qa73/Fp3cMVqUjWWUfSXaL1AkTp8avv8MJzM
         2tpaWNbLwSx+RFg4K6446CdmdXcJVSMYYCfCYsUgI+fZRQNnEhH8ya0ui9R3uaX0rhL6
         bg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001179; x=1745605979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFANXjtKTfEx9kV/YD0moYxXkPIgDxsA41WYPtohNLk=;
        b=DfD7NCvQCl4XBQzpuyMYsjh7WQgIPnik++OqFFv+dDbteWxE81kEZFWZ9Qf9KyPMlI
         yw9R1WqxrPTgD9juQsx8fxdib6B+iyG3xT03HZzzo/+341U6KRxBDXQAV9ka/MfshVZk
         mmu/HQN7OlBlt7oaaHrhKy9nkBNJ/E+T0SBx98aHocGTnWeHZfAy/ufjuu8wyuj2hrfW
         +hTDkIMtVPyPM0Zbpf/yrarWDr5pRXHMrbYC4uuPKofr0zPOFjZHQAu/p9MiV7UUdbsQ
         14ff+8oBgrFe4UQXuC4gOz/IzbN6ddrK8tG8Z2oIu1KRGNfUFoAve5QbGE1qPmPeAhFL
         mdzg==
X-Forwarded-Encrypted: i=1; AJvYcCVCv31lp3b3yhOT0tHEzABNB3MZh1FML4CtPe/9knpAOxzsVRzo5wuC4XIgjNRxF/2JPLT5W62OsfYQCe7oy0U=@vger.kernel.org, AJvYcCVFMqCYaN+nQe8rfjF8W3CSMV9C1t+parxQ6h4FccePISEDj4cR8pjng8zO7y4AcJqdVq5o@vger.kernel.org, AJvYcCVdg0h/ox9pTpMpVSs294Jrs/vkl7u8Lwz6+GE3dppBU7jis/r91GJoqFRs2XGdJTWx+ud1J9QEGlwpxu2wiLbh@vger.kernel.org, AJvYcCWdEP0lb1EiHWqMeam0t9glxtbC/KJGMZig4sc4SiwtdoMqs1eziVHT4KTBda6uw7qIeP/oqm8tFYZFNe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrgXMqFevOaeqoJg3hkL6mPY5eglY7jH/WqP18RE5tdpANI0q
	Hwp7qDYTU/3DQELJYspcosEEPFHoCyJnpUc/RHvypz4y/8bFIyFqxITx6/SkVNUUov7b91IIMpp
	Wkl7FOgZLtlE5Tb+6vUpIzZEPI/Q=
X-Gm-Gg: ASbGncu1tjehtdweVcFwppYC6Qmkuyexnk5H135pjuJEUWDgHv+ImTcE1RqZcJ4NRgO
	usb9xkRg6cM/2j6gAv9/l2vRek0RgX16G5mtNjA1Cpif4ypwb1B7R96QF6zW1KfH12JX+XWJpmY
	8xhHbH4/rt7f1wPmDQmBKQSA==
X-Google-Smtp-Source: AGHT+IFADhdep+T0QJPWyAyGB7omOjzqUUQUGaXKFwOncpJL98lO4epAjyTx4Uxd27a0AOpj/taau4IzgTr9RsgnsRg=
X-Received: by 2002:a17:90b:1b44:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-3087ba5cf08mr1856703a91.0.1745001178768; Fri, 18 Apr 2025
 11:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
 <20250418161005.2425391-13-joelagnelf@nvidia.com> <CANiq72nCfBdsfKzP72DWxLBh+Eueack9sS-E97wtsr0UtkAnUA@mail.gmail.com>
 <42da7c8e-08ff-4b04-ab58-6c0c2e287eb3@paulmck-laptop>
In-Reply-To: <42da7c8e-08ff-4b04-ab58-6c0c2e287eb3@paulmck-laptop>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 18 Apr 2025 20:32:46 +0200
X-Gm-Features: ATxdqUE11d5kf2E85BZuTAmKAI_UEsrp_SwqW-Oi0y3Ijarw0S_IvhRNYkCwLgs
Message-ID: <CANiq72nE2cH93W2qZrzAxfbz3hjsw4Xy0YYNwOUQ74SeGiirgw@mail.gmail.com>
Subject: Re: [PATCH 12/14] torture: Add testing of RCU's Rust bindings to torture.sh
To: paulmck@kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rcu@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 8:04=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> Suppose we fired up a guest OS and captured the console output.  Is there
> a way to make that guest OS shut down automatically at the end of the
> test and to extract the test results?

Ah, sorry, I thought you were already doing something like that, i.e.
that perhaps you could reuse some kernel build you already had and
avoiding a full rebuild/`mrproper`. The KUnit Python script uses QEMU
and parses the results; e.g. you could look for the results lines
like:

    # Totals: pass:133 fail:0 skip:0 total:133
    ok 2 rust_doctests_kernel

Cheers,
Miguel

