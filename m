Return-Path: <linux-kselftest+bounces-27806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E7A48B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40887A28E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E726FA79;
	Thu, 27 Feb 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5bxON9E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016A225A48;
	Thu, 27 Feb 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694647; cv=none; b=YiscVXbC72QEjKGP6GQvol8CVFh/XVvGJsAl74BcJcVeDsKH2bR0PFEWk210qR1zLgyU4YIUcOCw6uIf4LX5Y1POLNn3CdSgVjS+Tpq1cYFMupeVPVz5aeJawHuqLSt3aMyMHpcMBhGa2OnD82ydmzbIJ7XhXYzc7ACLpFX8Dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694647; c=relaxed/simple;
	bh=1UDX2cBC01g5eOq81gMwt1eGtZxI4CzsIOv8RDNWcuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwyGDlWSbx8n88JL3QfFLz+JjlbN2SqKwG6yCm6IG9ydiYCrscIlXPWUQTZF8QXlrxVyjrnGMYJxbp5tFzlc7YfsDcY6p91y4jyNzoS/VAUWWo0X7AEgPjdqLZbCFDMUsz9GFV/x1oZbs6sxq0gmlA+oTTYsnaxDNbiXlhQGrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5bxON9E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234daaf269so40022885ad.3;
        Thu, 27 Feb 2025 14:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694645; x=1741299445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtWIjNlWm7vnqv+thl0o42TinZDODXYSuqfAGagu6J8=;
        b=J5bxON9E5WgJvVFu4mRZRvs7+p38TZUCEwa+myJXQOwb/1HFJwGPNPoHIbFuJ2tbOe
         ByFoyJJS5a59bqM0gzwI4E5Cev1uwGKiPZ+Bb0CoGuXiYgvZX13a/uM6Io5h5b26qWKD
         zI1QayppXaHuZJ5fys4zDVmGI7oXIjJ481F//DhgFbdE7iEaJsX4c44kBEBmhgS/NyL8
         uE/ZA111m5SGYXzaNP32hO+K4SmVSou29QXVUhQU5eVJxjrND0Xf+qyaETY5FZgMI3PW
         vRZbZF5V8eWsQgO4Szs3IN/c3ruY4aEnh4wHesbQopyJ1to8C/iW+v5OO3yzoBozw40M
         EJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694645; x=1741299445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtWIjNlWm7vnqv+thl0o42TinZDODXYSuqfAGagu6J8=;
        b=uzcDKdNoUPTZwfPchsN+obSSBYVKNOVr3Z3MPBkxXJnnAiJIVziE7ChYNXLPvsNd/m
         taBm8XV+VCQJHuUj6EkQveEoZQ92svyIlIRvQ/YgYwncngr/DuLGXAwMVmqqQDfPsEhd
         BZOLg1a9HofejKuvJikJTwrBentgF0o1cc0rW9BUh2dxUfUFrYZ5J0NY4un+KRY77ex7
         VY1X3OKGJT+Hfb6c5w/i6q7qmL0KtwIpiWm5ctJIbVYGGIZz2exagRGAt0QkqgdluEua
         /EIxBA8jMHjFa63ec5QpEDUifcmbbUAnD7XAncYnZRwdLkXynp3LkyjETBjcOUTPaA7v
         MFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8sVPmQrc8rqW5blcd5SOJlDe9KTpckI1RllKS6vBxkwF8KIwrOdQgozx+b6lbt0/GG30=@vger.kernel.org, AJvYcCVH1NwJVEYoGnFhBK+UN+IrcOocdUY9Wb5mS3kZf4QTD6REjeOwje0It9W82bUREc991xBKKPXVjS/udBnT@vger.kernel.org, AJvYcCXb7/6tyH1gKLElMiFVVZkC+W2hWbTOjdHgk+8SkdF+NPF25hDUa4YhPC2FGxxDT4ULWy5DfTVhWkli77hRod8b@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyx9fJ2F0vvf3PLQOjy+qIe1i64KqLSJuqdZiL5XbyytxVkz1
	n4qtn0YK0aAhdYdBCJns6m8GsWrEU5pG1eEzE7NtXpIb8ruVQik=
X-Gm-Gg: ASbGncukNHtwl4XH5ytVrSwPiwAZ5+/aKxNdwYOsJFKTu2pm8Eft8ztfxD0YgR+BZ3m
	FYGd3q6u/+66P8WOCCA5qGRwl3NN6Z0glzpEC629NjGSYCoiSFyFGlfTj366lOPQOuEPgS8/YgX
	wvDLcy6T8ifJsAzxR+1RGpTY58XDrILYp8ryNCTW7/21lA6IOIIizWTN/moxN1BXXa4IjbXRdeP
	kCjwixeCkKrXN0IDACaQPEo6HiJeFwdP880lY+8u/muW/0Xdk1spQUBgxYhx4A05HFMWuCiFKyj
	SuDsx+urOUPXgn20qPbWpSaD9A==
X-Google-Smtp-Source: AGHT+IEC9wUltlqSimc9UlOHUUdvuJW+F3/FOIxa0//HGrcPPCSuGGTNe6wHvfrLRp+80e3bS157Lw==
X-Received: by 2002:a05:6a20:7283:b0:1f0:e7a4:8f7c with SMTP id adf61e73a8af0-1f2f4e01444mr1464842637.36.1740694645558;
        Thu, 27 Feb 2025 14:17:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7ddf206bsm2061142a12.6.2025.02.27.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:17:25 -0800 (PST)
Date: Thu, 27 Feb 2025 14:17:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 03/10] selftests/bpf: test_tunnel: Move gre
 tunnel test to test_progs
Message-ID: <Z8DkdFZ084a6CTt8@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-3-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-3-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> gre tunnels are tested in the test_tunnel.sh but not in the test_progs
> framework.
> 
> Add a new test in test_progs to test gre tunnels. It uses the same
> network topology and the same BPF programs than the script.
> Remove test_gre() and test_gre_no_tunnel_key() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

