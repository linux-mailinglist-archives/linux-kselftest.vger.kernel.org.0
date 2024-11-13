Return-Path: <linux-kselftest+bounces-21957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8E9C7A09
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EF1286F42
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FF2010F4;
	Wed, 13 Nov 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbdNZDdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26C1FCF78;
	Wed, 13 Nov 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519286; cv=none; b=OtqnKG77Vhzt1WpwI+jyl0nnBWcpA9JQ/3WZqYmPMSNmK3HRyETYoH8l1KUXVC/wG70cDLCBgVGPw56hlSx48bMoRJ/0ifJZKYP0BY1XPzCsOU+7Qc0KqOOlYh7NtJIBY17qy5357NY6gILnpd1PLkuJQsiKTnjjTzFtKWZh5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519286; c=relaxed/simple;
	bh=TCNaFIfv7lEY+0noNZ//2HmAPvDmOrK6PjaZP/LM0wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTEA9ecxlhUBadagGWhHJ0j+ODqJmvZW9CLNrrdxXVG3004Aqr4HSQnICSB4H5KjyBMHqjSNnbVUFoIPGIgosUL8SBX3lU1UiTgPwvtDX6Ebmdo9YNGaR0IWEEK+/5o00RPCYdlV6Zx6jaZsju6ejqnkkvBXPspnf9LDOUNrjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbdNZDdp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20e6981ca77so84346245ad.2;
        Wed, 13 Nov 2024 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519285; x=1732124085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NeR3WHmqojr6rm3S6Th9Ht6BHf7RWJi8eTYxBh8PgJg=;
        b=KbdNZDdpQFYGzEcuYTo8Q+UwzkLz1/uAd47fglrIJ+m2YabKRWB23BeekPSf7yI1Sd
         /uMS9xD7btoQljqcrIXCtdzeqhPiZLU7dKqWHYxjtAuea9ozwwEgP+TS4OHgQC7ty6nG
         jK4pphd5iI4Jdhmj8sem8StOYlnkC7zz5hYxVRR+BIVRHwJVa6AkrsQGGVdWkSaSYa9X
         Czgb3xZWBMoDm6Yh/Okecbm0NuCxlDRcZXvc3xPlMsZyt/mfrfDFYY7IDOpi3rYhbWd+
         83UZruPfToxcaoXtstfKTj7QEJfFzoBAjMF3x7EjNiR9UNyg8TsgWEv+ZP0U54v+mxVm
         OXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519285; x=1732124085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeR3WHmqojr6rm3S6Th9Ht6BHf7RWJi8eTYxBh8PgJg=;
        b=TAaY+BVthYR3JMbHmgZlEk49Pj1GwVID6TX/pIBbOiHxBmVXsLJbDeRSCud4fZtwqW
         mb0JNY0tUYg18LkQ1HVaD/cOodTawOe6m1XgY7rZYORDmWWJlq14QkwUj0fpe+GU/OpX
         ebqcOZzUENoeNcuBo+muY6+yHDkT+XClDwDz7CDj6mrUFCz1ljcMfjLMWczelEdCazQX
         XpFy89ccuym5VMy/sUz68WKUu+GGy+c/sp1YA9mIVpMVoxobsqJjo+ynLi36E99YzEap
         Sp/l9XmDYgU3xy6FNgT5vLxiBCSuyrTRaRbpQZHbGdua6fqTbWtrUU9ggRVSk/QWpC5z
         P1vw==
X-Forwarded-Encrypted: i=1; AJvYcCU10Ozy3KS5/O8BEace0cyeWKSRlZCFQFcJzoONVG4NZuWf99sLW9u1LyR+aWpjIDi4gR80sXNoGk28S1aG@vger.kernel.org, AJvYcCUtFKJg74UCkei9DyypeNxdsp+lnsDyAUIyDQoCkxlRpULmzH6FtG+nNtSzPFi67urKG74=@vger.kernel.org, AJvYcCV3VYvjRdzKwHQNas44pS+iTLORb7E9nQTRpC/TuwfVpl5o/ITzwGyjB5NRbUtS4M3UcWPTAoD6PiM82lnDNazC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+jPAAyMf+f+OhilvD4ka75fG0bPQpAM0rlTbC1bzNkg7z11F
	8+iIuszdsz358Oec3aQQMb3dJ5EHg72cTs9ZPeZYp5ZVrcZ6d9Y1mqDU84Y=
X-Google-Smtp-Source: AGHT+IHrDlNFx8RsW3SQdNK9PGUQe2v6475Teh8RVEq77X3TX9l5KmFqyp+uZSAUj2mpcPlE1atWPw==
X-Received: by 2002:a17:902:e5cb:b0:20b:b26e:c149 with SMTP id d9443c01a7336-211b5ca46c4mr46005445ad.29.1731519284668;
        Wed, 13 Nov 2024 09:34:44 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc829dsm113054755ad.40.2024.11.13.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:34:44 -0800 (PST)
Date: Wed, 13 Nov 2024 09:34:43 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 03/10] selftests/bpf: replace CHECK calls with
 ASSERT macros in flow_dissector test
Message-ID: <ZzTjM1l972hLO7e_@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-3-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-3-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> The flow dissector test currently relies on generic CHECK macros to
> perform tests. Update those to newer, more-specific ASSERT macros.
> 
> This update allows to get rid of the global duration variable, which was
> needed by the CHECK macros
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

