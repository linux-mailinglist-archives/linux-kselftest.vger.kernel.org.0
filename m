Return-Path: <linux-kselftest+bounces-31840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095CA9FF08
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F7246773E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3D1917F0;
	Tue, 29 Apr 2025 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvyiLO7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81B433C4;
	Tue, 29 Apr 2025 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745890056; cv=none; b=WRFRREnHv24BsjfSQwekwjVyrVBd7x3t1mE05UzvbElBL6xFdN/qECS6GWomANe1/4ukx8InAoiOL6xKLx5GqCdUad/NsT5P64j+4inWiD05KIGRXPZEwIiVWha/K3+dXEIowpv8rm7I/m3liUsYqNiUSKWfnbwNrOO868yUgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745890056; c=relaxed/simple;
	bh=DB2J9NyQh5bEG5N2eEO3SauXvRnwrNA9NgWr3zuafjY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UKxZCRM+rZFe87sU7A2Cwbb9Fxf/c0QDyaPrinw83KvhhEKDij6AwGaNciIWQuzjTMENg7iMHaGEOyN10IDeQljtzddxkeRBnS7B91Gr0bQ2lLP7Obc9Q1JMatmBudtMpjxGZorv+4sqHGuTC8kSIrCy9E+oNIEuGSsxLKU9+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvyiLO7y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c7913bab2cso579930485a.0;
        Mon, 28 Apr 2025 18:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745890053; x=1746494853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlntZd2HKxMdLBz7SWXJj9gL9VA8qG4kpiiSWL6iCyo=;
        b=RvyiLO7yDrRVqmwbZPW5Gqjw9EGQJLrrEXCOqm6UgitQAal1E/Dt1TBu/nqZOVeIop
         n18PW20HyMB9pfKPsza5hLKQzbgMefU8igSVlZHz6E5Kr102hzg4cW4FcggBjbhDx3PB
         kpXFC+0gzHqLo14T8VUBajrmDwCTcbl5s/SZ4+/qk+/UNqMoLQ7h1eg2hqKPQ9f3XlP1
         Eov1m20wFoPdLqgRD25Xm7/B1jF4TgdHpFzbSUn9flroPcIC3h4SSpNQgSLe8noY7yd+
         J9U6YpiKYk4eDY/q8z/jiYK8UkpI8cbXsPkXzHtE3Kne/i9yzrcLnpNWRfGIr75TQDqr
         3lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745890053; x=1746494853;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlntZd2HKxMdLBz7SWXJj9gL9VA8qG4kpiiSWL6iCyo=;
        b=rkzOYcB2RBsrLlIdw6Q675G4FIMP9tVFZM9bJeuZKJEIlkiYEDbj5s7m109BDYjTqT
         9huPqDPdRYVreGtVbl4Lm4jS7QIFd+e3tD0nbfM7HlxITkBOD7gVyLjqxRworKMnemKm
         GjKf34GFgOfODZGGFxR7laEg9hilIOF2g5KvIrx/q5MOOkvIjsI1BCxbb8R4muFu7S82
         hpJME1oNtg8rj3KaH7B2s6hSEiY5FDwunavMBbwXoeqW86MIgGQ+0PYNqM3GMk/Bn7TL
         uT9avlyzgA23bjJFFaV7r4+37PbQ6S/lITNnti33xSMTRKxKskUpMCM3KiBYfCCx9TmI
         C3eA==
X-Forwarded-Encrypted: i=1; AJvYcCVj0ncLn3hdbGIcQpDGXyYXebj/vL1/byYaLwoLkrtzov8Bub81vjrzMhU3mEuwozniQdH3TEDa@vger.kernel.org, AJvYcCVsTmQIx6dspvJpsojkLqfKrZ0H2wsa9gOxs6c0tAt2oHGBZqSsaVlch8o+uR6X14176uoDUCmxUCKAKdOL2Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVOA+hYOhUNSjUoeSaH117ZJs6K8cW52wFh7TehwbAg7raWKH
	+M1Z9IYo7lUP/ah7ErJkDF7FLB2Tyv5G9E8WRBGdt4wcQdqg8lgC
X-Gm-Gg: ASbGncv00VeJRmEFuWSWgiZidqy1GD++dxaF3ojUGlkbTsd1/JDVhQt4HtkwyS9ve4u
	OaSCrIQU4342SdQYsL9ojHOZGlDoxG01uW19TRu5+NwXcED1ZN+sWaBRcZfOwKrXrKd1AhfmbYs
	zsyU/utsQZOSULBdfMCVCyQKQZiknPZ3RDt1QS4ntalLaZSKmP2NJxLDbJL7HEa1/TmZNgsVM+h
	KVgCEVrOEEeWOCeNy3O3pieT3P8Zhf7MpbZPsA3ipmdAHU6iTLJkMhxKJNLowpVZH/9pJwRV34v
	Q2f/3UjpFW8Z0bG9Wu9dhEr/adJq+rh/AwcTF1/2UAR4U3kq/f+jLmRWA9cLjPjMuWxo2NrNFwq
	clcznH0kE8SLv4OrJGmezLVvc8uyKb7U=
X-Google-Smtp-Source: AGHT+IFxrN07Xi4RzdYiJI7PRn37DWy0riwdJhnZpj/wgZtI1XdlgrbYJyxyjP2vM8N+bfNwkymqeg==
X-Received: by 2002:a05:620a:4248:b0:7c5:5d4b:e63c with SMTP id af79cd13be357-7c9668d4a26mr1688295085a.47.1745890053383;
        Mon, 28 Apr 2025 18:27:33 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47e9f7aade9sm75351281cf.40.2025.04.28.18.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 18:27:32 -0700 (PDT)
Date: Mon, 28 Apr 2025 21:27:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250428132425.318f2a51@kernel.org>
References: <20250425151757.1652517-1-kuba@kernel.org>
 <680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
 <20250428132425.318f2a51@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: exit cleanly on SIGTERM /
 timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Willem de Bruijn <willemb@google.com>

Jakub Kicinski wrote:
> On Sat, 26 Apr 2025 11:15:34 -0400 Willem de Bruijn wrote:
> > > @@ -193,6 +198,19 @@ KSFT_DISRUPTIVE = True
> > >      return env
> > >  
> > >  
> > > +term_cnt = 0
> > > +  
> > 
> > A bit ugly to initialize this here. Also, it already is initialized
> > below.
> 
> We need a global so that the signal handler can access it.
> Python doesn't have syntax to define a variable without a value.
> Or do you suggest term_cnt = None ?

I meant that the "global term_cnt" in ksft_run below already creates
the global var, and is guaranteed to do so before _ksft_intr, so no
need to also define it outside a function.

Obviously not very important, don't mean to ask for a respin. LGTM.

> The whole term_cnt dance is super ugly, couldn't think of a cleaner way.
> It's really annoying that ksft infra sends 2 terminating signals one
> immediately after the other :|
> 
> > > +def _ksft_intr(signum, frame):
> > > +    # ksft runner.sh sends 2 SIGTERMs in a row on a timeout
> > > +    # if we don't ignore the second one it will stop us from handling cleanup
> > > +    global term_cnt
> > > +    term_cnt += 1
> > > +    if term_cnt == 1:
> > > +        raise KsftTerminate()
> > > +    else:
> > > +        ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
> > > +
> > > +
> > >  def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
> > >      cases = cases or []
> > >  
> > > @@ -205,6 +223,10 @@ KSFT_DISRUPTIVE = True
> > >                      cases.append(value)
> > >                      break
> > >  
> > > +    global term_cnt
> > > +    term_cnt = 0
> > > +    prev_sigterm = signal.signal(signal.SIGTERM, _ksft_intr)
> > > +
> > >      totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
> > >  
> > >      print("TAP version 13")
> > > @@ -229,11 +251,12 @@ KSFT_DISRUPTIVE = True
> > >              cnt_key = 'xfail'
> > >          except BaseException as e:
> > >              stop |= isinstance(e, KeyboardInterrupt)
> > > +            stop |= isinstance(e, KsftTerminate)
> > >              tb = traceback.format_exc()
> > >              for line in tb.strip().split('\n'):
> > >                  ksft_pr("Exception|", line)
> > >              if stop:
> > > -                ksft_pr("Stopping tests due to KeyboardInterrupt.")
> > > +                ksft_pr(f"Stopping tests due to {type(e).__name__}.")
> > >              KSFT_RESULT = False
> > >              cnt_key = 'fail'
> > >  
> > > @@ -248,6 +271,8 @@ KSFT_DISRUPTIVE = True
> > >          if stop:
> > >              break
> > >  
> > > +    signal.signal(signal.SIGTERM, prev_sigterm)
> > > +  
> > 
> > Why is prev_sigterm saved and reassigned as handler here?
> 
> Because we ignore all signals when cnt > 2 I didn't want to keep our
> handler installed. Just in case something after ksft_run() hangs.
> It should be equivalent to
> 
> 	signal.signal(signal.SIGTERM, signal.SIG_DLF)
> 
> if the prev is of concern. Then again keeping prev doesn't change #LOC

Oh I see. Ok.

