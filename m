Return-Path: <linux-kselftest+bounces-38707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027ABB21617
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B15D463B02
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1926E71F;
	Mon, 11 Aug 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgxlaLgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518BF311C0D
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942457; cv=none; b=LzYsDDVmMKFJ/X+WUHyT6MoC5CXdehB1SilJlR4rUqD8J3iTEOqFR4sZTARIwJl7NJw2/EQSX3INvHuGdFTV1cAnx8YN4Mzx7q3AY/TgsHcuOzxSO/WGmCDjBkUaPEPSG5Pxl1K6PH6a1gTbl7b7vFZ8A7pKXgpZ2oSxQ1Ww9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942457; c=relaxed/simple;
	bh=L4YXtkQXfZckaIdKwKMsKAjJ8efy4VJnuMEL0sTzy+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLSU+mvcE4HAsOu96tAKHPzw/4dwXi5HNMcg4jiVtoag4Km9mT4RPjNnGok/eiv5/gHmGozEi+/MEqsXmBL5invkNE0QdNVp7coIDlnOL3hJqUUm0JwoTToP1AxkJ8FBXLj1rhuJNnincNdp38oib8FvqT8tozlEkslC/acgwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgxlaLgX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0bf04716aso13661cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754942455; x=1755547255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDMpYVLhya7xt6pcJRlpQYegHBJR2O2i28Y3lt7//0w=;
        b=DgxlaLgXDcC1u6N2FFVYN1yXqsox0157FBS4OKEO0tTAspWIzkUrhqlyLeI1ZCqQ1I
         +Tj7446UyOzMirvnAD0/n18KOrTJc4GstAZkmLOGJT+7Vx6hD44ciiD1lGIhgSXxnyX4
         I4P/EDEDfVFf8cYgw4nyBbbINRHgkZve/OyCVNY7IdceOs7ziwW8+uyQVdRJuFtrIVOm
         5/vQzwUqqBYfa3I3+Wkl0vyZjfOYcQbjG95RtarOp26tpee07snDr+DFnkF4IYOJx3HS
         If1h/CqYlQnbAoYsTtWXXGgShYMiFUzKRBYX7nSpKIKkH5GpYh/12wu6qnMl0YbCS6IR
         B4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942455; x=1755547255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDMpYVLhya7xt6pcJRlpQYegHBJR2O2i28Y3lt7//0w=;
        b=F4i/lbD9oekhO6eZWGEb1vChe/Yp73fD53/swCPniY1/bSJLjxkEYlxbBHsL9niL/d
         mVzBlJzR1QHrvNgwjG7w2wTV/EF6cHIyfBSyHKMSgzcjXLKLVGC8ucbTbu8WvI33v9wO
         BjXkcCdBySPPubl/2qfIEfF+gYKK6TWpbvffKDoIijVQqqpe4XevaLarOAtXAG5GQpxL
         JaQpKwwrpOMPdQLkHG/u/TBo0dDLMYJNfkEfdKS8bCkkW0yjNCOxoHGTFkuY0F1Jb9FX
         ksWJ2vnn98doFDvnSj+JZxoYZXfcwwajK6wF0+p0/sQVT8JYgxIOqaVmJfMO5UD1UWSz
         lDyw==
X-Forwarded-Encrypted: i=1; AJvYcCW0WDtckzaKhLmaaDX78HoDJtgbLLNQ9XH77Sx4QKEG9bMaYu6ZabE6yDvA99viXvqC5DPDcHeok/wcc4b26Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdNCmN8COeglW/D/VI+bcyuE3z5j/RbfzwKll/nHYQhowKY0Q
	A+yZ3AV5o9ZPi1rov/py5CdavoqT2JW+K7qXKkqTF59hX41NFnm+FXlSgmTcW0jL/U6wAHyJKLL
	DluPi8xzGU39s/wJyHPlJuh6C4RcOvnguqKpA9zS/
X-Gm-Gg: ASbGncssaoL+mGkcdz9CDrmpGyizrDZEEDlED4K2x25BEecY/DyAgpm0U8BH2ho3ef1
	0/QOnU0v5CmnDGe4EMSjSCjvGjoHEd7gP2EB0SMaJOw0AF/G2kxjzRnyuLBZg/LnDGfkYZI546S
	b1Cv9R8LiKX0azPXg5nf4ymWkVxbAE3SYbjR1fgV8QD2nf1GFO9FSn/dr/PQlxc3gB7hV5MbYiq
	I5KI7KddN0sW0bC/c1xS5B5e5ii2O8ZlhT9rFBLQuPe3sgi/g==
X-Google-Smtp-Source: AGHT+IFnZ7fy1xwedpAUaDyXANbyoUaCqbxMXnRugbDvj2BgwPIs5z0a4CpRwliBrgHuoskcDuY4uhxOKTqPW4PVJ7o=
X-Received: by 2002:a05:622a:155:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b0ed6f6917mr1098121cf.4.1754942454725; Mon, 11 Aug 2025
 13:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <aJoqqTM9zdcSx1Fi@google.com>
 <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
In-Reply-To: <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 11 Aug 2025 15:00:43 -0500
X-Gm-Features: Ac12FXxtecFo3JBHw9Xp-7a0InhBFaCf7hmpSP4xc_TquqGEkQU-IMkjUJoXAjY
Message-ID: <CAAhR5DEG=Z_5DRGXcdoL0cxcSyuTqRGjixsGunDqtV=YtraOWw@mail.gmail.com>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"Afranji, Ryan" <afranji@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Wang, Roger" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:12=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2025-08-11 at 10:38 -0700, Sean Christopherson wrote:
> > Please make cleaning up this mess the highest priority for TDX upstream=
ing.  I
> > am _thrilled_ (honestly) at the amount test coverage that has been deve=
loped for
> > TDX.  But I am equally angry that so much effort is being put into newf=
angled
> > TDX features, and that so little effort is being put into helping revie=
w and
> > polish this series.  I refuse to believe that I am the only person that=
 could
> > look at the above code and come to the conclusion that it's simply unna=
cceptable.
>
> We were talking about this internally. Behind the scenes Reinette had act=
ually
> spent a pretty large amount of time (the majority?) cleaning this series =
up
> actually, to even this level. This was some code cleanup, but also functi=
onal
> stuff like rooting out bugs where tests would give false positive passes.=
 But
> the plan of action was to have some other TDX developers start reviewing =
it on
> the Intel side. I was also wondering how much time Sagi has to spend on i=
t for
> follow on versions? We might want to think about a more direct process fo=
r
> changes->posting depending on if Sagi is able to spend more time.
>
> But Sean, if you want to save some time I think we can just accelerate th=
is
> other reviewing. As far as new-fangled features, having this upstream is
> important even for that, because we are currently having to keep these te=
sts
> plus follow on tests in sync across various development branches. So yea,=
 it's
> time to get this over the line.

Thanks for the feedback Sean, I really appreciate you taking the time
to review the series.

I do have time to work on this one this week. I'm hoping to send an
updated version by the end of the week.

