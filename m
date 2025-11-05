Return-Path: <linux-kselftest+bounces-44821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36988C36A3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB3501DF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46843346BC;
	Wed,  5 Nov 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHbDbLIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577C3218CF
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359095; cv=none; b=eVsmMcLUqiPgFPRUTKMNai/QDLthBABlNuPaSdE75711h1JB4OK9nkSPmgMLZGvQIQ5mlRLce278LLlhyLV7NKEUBj84e/ZTMeDeq3j350G5Rgy4vaiUdcmmSTJ+686cuEc0ddiYHXF4jCQAMxwRckCdGKTaSu/Ysn9mMuxtKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359095; c=relaxed/simple;
	bh=W3rIEqDAjFHWAwm+pwB74Wz+AVL3IfQgKO4Y4lo7W2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6NB33njjTku9B9LCI+A86fJIVhlr25Zo1sJc7A03a6hAFt6BJnIM9BIMoNj4He9Opts4lrvbH6+8JYs7Hq1EYoKH8EPd4BVHTnY44/SKqgE4nKqZHTlL/73rrJvJnmXK1/+Z+fjB5mYMzkUb7JToxETx/MS68tkjU1DmceL0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHbDbLIt; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e1e1bf882so9782d50.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 08:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762359093; x=1762963893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymZ6xdXrqo7vWAgf0QChueJMpmkC1T045PA4GVzRwIo=;
        b=YHbDbLItjw4+eMXKEAHsY2z6+TDNrzIu7JCue8TYKGBW5rNDBDA4JyyM/UgPjyAf4M
         5MqkGFSQxKclN7aJD+qGLJCYV8vCTg6YPemfsPJrI3AV/XQJqcMzkaKNo0t8msTKlFda
         e0pVYvImharsbSWHL60w2PP/PvzOKgwAoZzx3jTNCWMoPWQBzVE8Htct92I7j5p4HMZE
         BhFEFcR3GXgmVF4F6OGJ1AgDCO4C0Dk3QKjpQlQJvUykVFNLhQIEiM9DB7tiQ78fkYeL
         41nBDihiXKZ3pD+aMvDrHd4Kdyc90F8YhaprnNZCz7GEXfN1+UFPvh2qp+b46wLn+QxX
         /s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359093; x=1762963893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymZ6xdXrqo7vWAgf0QChueJMpmkC1T045PA4GVzRwIo=;
        b=fy2DzT0CJuwzGJR9+SEFUAbNd03L4eIu9BUrcEl9PEV/+TeMTkUBvwaMJyjZESJaDi
         dQPS2vpcZytOPcOwoOKHRUwnen7wQulai+pkjt56oaWmI1Oyms5eJ5Jv6GpTZ02cQGnJ
         imlm0L0qIUoQklEb4SJkXsvl0W+NWM6EQWaKj0+fRsmIL67KOTV2Vuflf4Nda9popIYu
         78gve+u3CItwUTRIZCLav0CVjQ9NDYHv2uIl7zDzF7rifNLPt7BBOyT4p4ubWGYXhp6c
         ZOvwkCTHyo9cEJNqcX3toiOwlYykEUsHHdrpRsL1Rv7hWy5+STlW3kyjTdRaKsriTiOL
         WKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUHIEHTILTJzBGjq9zzmFEXF60kSuEbjVF45wf6PojijKFlRzICQaQIIi2WlLWCMBZxQe7boYXsqH32LfvwaN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybfHmwrU+UCPd0NojecjdvRf82tbOJk9st3O3ZC56VB7aIQPNf
	9MddON5nDfHUdvzaVfgR0UXELE4fMvqrLpcPVYxJEodPIqXBU5Nsn65BPUo7uEtr
X-Gm-Gg: ASbGncskfDMphdUxeIhjuuqq80r9uh++tSSH2iP9f6oT40KMRyjrD60VMuMByB9oMo9
	a2Qo5yKUwrjeGBAPvFODKx/l/lvR+3POMvncPbVe7yCaSxGPdoWHhPJwF1uS6+N3mGgnRGFEIEO
	vKdz1hIMTWCchn6+mYRo4OvPnnE/QuhfQ/DoN1eFVWY1sDGSecdJa+ws6NIurSL6AZSAzQf9XXI
	7lgzVWLQCt7FExRQYhMtv5i5WWrPcjrUi9Y5ReWItbez4P99pYVKuy9pogG1YAx3aUnJcbiPuqm
	BOQBfSidCYDj+DQKIjuUnYJNcpMQHk+hRyBtx0Pw3fwZ7TH2F3bVz7tCPlj8/8PJzMdfpu09EZf
	EJ6DdSEvuUvaqQPA9cfDRnYTW6akev/pMQLmRf+kKItj0aSzYFs74f73gj/vb7AUbaQVPhormLO
	P+ZD/oOC4SXkyLlcHyisaCp+O/+SJubFFlXoo=
X-Google-Smtp-Source: AGHT+IFO1Aj58ygyCOlI2zA+lUSTMddFikFOwBkJL3a+he6zkxfPMBnlF0h5B3IACmlOERHv2GNjEQ==
X-Received: by 2002:a05:690c:9a0a:b0:786:581d:f24b with SMTP id 00721157ae682-786a41e29cemr57871067b3.47.1762359092678;
        Wed, 05 Nov 2025 08:11:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d8f0b4sm20313777b3.4.2025.11.05.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:11:32 -0800 (PST)
Date: Wed, 5 Nov 2025 08:11:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Message-ID: <aQt3LitYPBcD0MM+@devvm11784.nha0.facebook.com>
References: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
 <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>

On Wed, Nov 05, 2025 at 12:16:42PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 01:50:50PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Sometimes VMs will have some intermittent dmesg warnings that are
> > unrelated to vsock. Change the dmesg parsing to filter on strings
> > containing 'vsock' to avoid false positive failures that are unrelated
> > to vsock. The downside is that it is possible for some vsock related
> > warnings to not contain the substring 'vsock', so those will be missed.
> > 
> > Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Previously was part of the series:
> > https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index edacebfc1632..e1732f236d14 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -389,9 +389,9 @@ run_test() {
> > 	local rc
> > 
> > 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> > -	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
> > +	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
> > 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
> > -	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
> > +	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> > 
> > 	name=$(echo "${1}" | awk '{ print $1 }')
> > 	eval test_"${name}"
> > @@ -403,7 +403,7 @@ run_test() {
> > 		rc=$KSFT_FAIL
> > 	fi
> > 
> > -	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
> > +	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
> 
> In the previous hunk we quoted 'vsock', but here and in the next we did
> not. Can we be consistent at least in the same patch ?
> 
> The rest LGTM.
> 
> Stefano

Just sent the update, sorry for the oversight.

Best,
Bobby

