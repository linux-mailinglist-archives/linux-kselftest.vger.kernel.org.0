Return-Path: <linux-kselftest+bounces-37350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4E3B0583B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 12:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02F07A9494
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0C2D6414;
	Tue, 15 Jul 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp1FxTpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499F223324;
	Tue, 15 Jul 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577110; cv=none; b=dEe/Xw0EXTUXaS8mcFOK/QPFROKt1K2FaF2rPek6ZHguPXWgdkpPBWH1Ksweu9flO7gt7vHqGqb3yMiGM6G9DtcU9KAN3ngDG5EsF6oeuHIBsF5uSLyxacu3QARS31Ko/rOzL4U5Zk7qgiAGggeru7LZsZqiZKxkAPZAKGDQVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577110; c=relaxed/simple;
	bh=YR/CAMidyDAoRBYeL5AbGJjR69wuwI0LVp+h3GpgAoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2ZrTp3pqAPXaTrtPIvoEDE5kKsS/4eViqtxnBgxa+wseDcSOO7Q1d0t0on9rPJu94jywkoceGXhAzqr7NlarYtljIwXYHuptTmF308etuZlIP0VqhnWCSaGC7kgTKWGSXuZjFLsranmPvAfzKqGC0pWHiCC/rSqGFo26eZAbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp1FxTpl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236377f00a1so49487115ad.3;
        Tue, 15 Jul 2025 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752577108; x=1753181908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndUwURMf+U4OPYsflaAXYVKWP+i2ltXh1RMS/eDGRPY=;
        b=jp1FxTplmQKM1bQHcvyl6eIGrqSk+m4vIuwEQTmqiydFijYKBdf4ejDvgE/nV2smrM
         LBZxtVfL7Er4e+dD6dkQod8LOa0l3kiIGk1w0nnYlmHuIIDAcslxR0zubX8KBaYGa0Hh
         1YV/iU5ANSFE8VE5y/e1X91QGJFCohg3lCAOwn1TuHlplYSJqcWklRCGRFJLhj/7sGuV
         hrBmYZ4CxM58s8nlXF64uy6bg3RHS52HWGCSmQZcrt4ejgcLNMzqG8K8EvMc83ZS8TfN
         dzEx0CSyx3Pnk1gJEY8TLqmLbNAGZdkkxXzbMR9eSLhZ12Ac2XoLiSk9WDVFMYLtU26V
         VM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577108; x=1753181908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndUwURMf+U4OPYsflaAXYVKWP+i2ltXh1RMS/eDGRPY=;
        b=oS4X3HEvSto+Y4XhyWAufgDxGK9ZoaS/AjGnwVPKroLZwaBTNT+kS8ogfckLBjD8gS
         Zygn4clpgUcG1GMc/QerEBQ0GFJcTdILSf28AzrPZfOi3HWfdXFlNTyWsuKXxFIr5w3e
         rXWvRsY+SUMwPT7JP5DmTxq2H8tSZneJjliSmPn7ccZWuzAgWnvWh+mhof8NK/fnbCNN
         Ntajd9+ikQTV0eEuDdNtXfebe+NZoZFRV2cnwt4g9AFdltZjbSSBILbpTZiznNZWX9J7
         lfN5IdRen+WUG9UeOCN3Bm24fz+bMNP4o9eEw7PjCdHbX2Y7k/zFIujFL0OELdR6RNaE
         fSjA==
X-Forwarded-Encrypted: i=1; AJvYcCUG3XLcuYeiCNE4UqfDRoE1/S5RtftJ4TGdSTe7aWWDUZMWw7tL3qF0qaDT4wpa0P2lbjpKFnzI8K/inD0=@vger.kernel.org, AJvYcCVOGWeCLonLxZ9g8hWQFfKBBLQzLczX6jhAfwVb4ueuMdAVU3W1/5wv4nqhfn2GV89hiZMTVkMtrTpLVQ9QJQlH@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqlJTHQRJlGvni2zUu9SLLnr7NPUGNyanCNBIyq48ZShji+D+
	Wj4FcwduNjn5vWDKr+GCD5/T9D6tfdfna+8B/dCkrQTnPwkT2ROnrZc5
X-Gm-Gg: ASbGncvbvugcimhIiVrnOmJSYP8OfJMfdtwjSjOLJFlTDjeGBGdHytHX7p6cNI/j/Zt
	1O6mpFJqppq4G24x+JFtQTS5ez/5w6+pcp7AdUXSv1f/A76dFoIzgtdr1z+Stj4svswnJ0Rrx56
	IOjzzlvysPGGzumqIBlZ+qrqzoTK8rVKAzrndxzCGLB6JItYl3lNvq+lgUIhl1Q5QK7AmbToHCP
	Sm0ov5SjBm2CiaUcjDQX+z9d4Y7fF7DOT0eHDOg4oQQ/Oja4RLMdW4RZgAvPTRCtbVnJEqCZ99X
	JhAQdbaPvSelsS6TaXt8OAUtWVRyNA/4JBxvd3nr685C732ST/YazyHYPoz9b4tEiufyQygfNq7
	xurwjRj2G2HeKROZ0jBU/Ifppwh9fHQoFtotNTDaHFRzZj0T3ShjQ+7A30P4=
X-Google-Smtp-Source: AGHT+IHZojJB4KCQsrcoAN7BT58wij39BFDsuKXOI/dCz++AseZJzBELnhlhFyg4t821B7aHJ1/pnQ==
X-Received: by 2002:a17:902:ec87:b0:235:779:ede0 with SMTP id d9443c01a7336-23e1b191970mr34025165ad.35.1752577107918;
        Tue, 15 Jul 2025 03:58:27 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322dbdsm110059255ad.127.2025.07.15.03.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:58:27 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: broonie@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v5] selftests/mm: add process_madvise() tests
Date: Tue, 15 Jul 2025 18:58:05 +0800
Message-ID: <20250715105808.3634-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b01d1d06-9d7c-4081-b3e3-c2c0fea06fad@sirena.org.uk>
References: <b01d1d06-9d7c-4081-b3e3-c2c0fea06fad@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

> On Mon, Jul 14, 2025 at 08:25:33PM +0800, wang lian wrote:
> > +TEST_F(process_madvise, remote_collapse)
> > +{
> > +	self->child_pid = fork();
> > +	ASSERT_NE(self->child_pid, -1);
> > +
> > +	ret = read(pipe_info[0], &info, sizeof(info));
> > +	if (ret <= 0) {
> > +		waitpid(self->child_pid, NULL, 0);
> > +		SKIP(return, "Failed to read child info from pipe.\n");
> > +	}
> > +	ASSERT_EQ(ret, sizeof(info));
> > +
> > +cleanup:
> > +	/* Cleanup */
> > +	kill(self->child_pid, SIGKILL);
> > +	waitpid(self->child_pid, NULL, 0);
> > +	if (pidfd >= 0)
> > +		close(pidfd);

> The cleanup here won't get run if we skip or assert, skipping will
> return immediately (you could replace the return with a 'goto cleanup')
> and the asserts will exit the test immediately.  This will mean we leak
> the child.  This isn't an issue for things that are memory mapped or
> tracked with file descriptors, the harness will for a new child for each
> test so anything that's cleaned up with the process will be handled, but
> that doesn't apply to child processes.

> I think doing the child setup in a fixture should DTRT but I haven't
> gone through in full detail to verify that this is the case.

Thanks a lot for pointing this out — it's a very reasonable concern.

Fortunately, this situation is handled by FIXTURE_TEARDOWN_PARENT, 
which reliably takes care of cleanup when the test exits early via ASSERT_* or SKIP(). 

During earlier testing (in v3), I did run into an issue where a missing cleanup 
led to run_vmtests hanging,which prompted me to make sure that subsequent versions 
correctly rely on the fixture teardown mechanism for child process termination.

So while your concern definitely makes sense, this specific case should be 
well-covered by the existing teardown logic.

Thanks again for the careful review!

Best regards,
wang lian

