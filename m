Return-Path: <linux-kselftest+bounces-20401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83A9AB1FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2271C220ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8781A303E;
	Tue, 22 Oct 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YonNCLbp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC81A302E
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610825; cv=none; b=nc6RjkDOa0YjNIwwta9SkeNGZTJdfslz+e2grwXD/RF2/fraJ4htSxhVmzc+DWd36Pw33+9F0fwEweExO5wsHyqFtHbk5ZO8XeVzhQNtx4ohz/C9jc/Lu/E+SiHlFzV6cfny1htUVaqAMgGuRc27R4UGg02b6p9pHXGW0+SR0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610825; c=relaxed/simple;
	bh=thVT5OYgYcWBEHUkUQDh5Yr2qH/GQ52rcQpAafIYa+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcknkUOLbwUPrQVQNcxhE9SfqPi5O5o56+Fq+cE2qBVDeu5bhPf121Gj7iaOk1BrxzpsBNp9SuJcGgFZeYQcPuHP4mWU5jW/X7mAWHb4H45E4nt2XflKSSjH8eFXktx8OJa+EvZvA0EBAT4u4DXP6bDOrrr98B1Jmw7FyCTwYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YonNCLbp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so53276975e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729610821; x=1730215621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24YJn0Eefr1UaXdhDfLXD5n6IqhczycLi2oTef5X5p4=;
        b=YonNCLbp72nLy0jkgOIycNNWRPnDVoNVSJo4IkYaKHo9Hlncq+5HQxqv2fe69xH4xm
         gwZb/NYH/u1SJmo2XzeIIAURO6C8OlFgwVE1ZEmjUXFhuOsGXCngTxTxj8jthXINUPIS
         Ntsv1HQgObgEu7ruIUOHARxuLt4tKlGrWzobu3UZ2twm4NFEBOKKqdpNr5L3WYSvpZEv
         emnxSxFddKojjzRdu1c1d3CXSo8B37755gG8/gOD9/mQk9m/rsESETk5fFT8lzy3Ze8e
         crB0k8n5RkSb5M2t9SHOjuFdWYfgqYIasBw6wtLqqqIUlJSg8ViZ9mRzW05yxXpI7q0b
         trCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610821; x=1730215621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24YJn0Eefr1UaXdhDfLXD5n6IqhczycLi2oTef5X5p4=;
        b=cBC6pfziNEaMqQJt/gAU14Ci2IUrDgR9idigtF0R0zo0WPoA3KGdSZdv8zGxrDlJ5T
         jkj45iYae7Q6hL2nISulYvplJaC+jQb7Zbsx6FlEzrJh/FiZ4aQi2JbJ+Tc01CEy5nb9
         yYJzy7g+SRqHX86x7cd5c4ooPqgM4bAbzET4bOFhvgEDE9HQ4s5DiznMqcaKN1xvBEXi
         lVozw97Fs7T4HQbCuVPuU89LdSsX3TKgRAE5YiuHAdqPJfeZ2vAnbnqrqsAiH7Xa6yyr
         id5/nID0BZTPGu1Q+Ts/NVouVrI0JVGiuH5v21MwyDEKF4QhRqy5q9L7RedF0d+98QkP
         q2jQ==
X-Gm-Message-State: AOJu0YyrDigbwJvTAVUsvckD599ln9o67PveqMcGUIUqhVhNws3s7IrD
	Rjm1x1Xvu7Ce/SX5lLTUOfFlYnCAz8vVuoby2Due7nLdAxOnKT+rcr561ISnrHk=
X-Google-Smtp-Source: AGHT+IE3Ze8qPnti7FmguM+/l3eMxeUIvDcJOZvZP6fCGDT29ykg7WRX+lbvHm5hMWtnHpDhwMszbQ==
X-Received: by 2002:adf:facc:0:b0:37d:4dcc:7fb4 with SMTP id ffacd0b85a97d-37ea2137843mr9684480f8f.10.1729610821559;
        Tue, 22 Oct 2024 08:27:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bc90sm6807726f8f.100.2024.10.22.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:27:01 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:26:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Michael Vetter <mvetter@suse.com>
Cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] selftests: livepatch: test livepatching a kprobed
 function
Message-ID: <ZxfEQ7WWfcSYfF1y@pathway.suse.cz>
References: <20241017200132.21946-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>

On Thu 2024-10-17 22:01:29, Michael Vetter wrote:
> Thanks for all the reviews.
> 
> V5:
> Replace /sys/kernel/livepatch also in other/already existing tests.
> Improve commit message of 3rd patch.

JFYI, I have committed the patchset into livepatching.git,
branch for-6.13/selftests-kprobe.

I have fixed the wrong substitution in the 1st patch as suggested by Joe.

Also I have made two substitutions in test-syscall.sh in the 2nd patch
as suggested by Miroslav.

I would personally prefer to do the substitutions of existing paths
in a separate patch (same as Miroslav). But I do not think that
it was worth another respin. It would just increase risk of more
typos. And we have already spent enough time on this ;-)

Best Regards,
Petr

