Return-Path: <linux-kselftest+bounces-28470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613DA56467
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676343B4247
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1E20C48A;
	Fri,  7 Mar 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKcRlBRp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B0204C2A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341278; cv=none; b=spuxU3r0EMO1kltPmib+wul0y1jpDQtDUy0p6zFC3vf8XtC8wqnQlaBqeGk8z5uuoPoW4bBLzvU1RMru58qiTGPVd6LGEudcT3s5MijZANf9KK8Svxxuwi5MVH5lNQDSHJQ6d1Zh9keBcVvTXAiJe/qPtd1vrV1Rj09cCDdn31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341278; c=relaxed/simple;
	bh=SNJTu6S+RxKk0mGGesiSe0L7+Yc327mwzneSBK2eWwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqAtQKs6WZH/VTqHKBWY1zXeOp5p5xvn7Sb0Zl/ioswPuQcCLTA0KKCd8qFl4IfZtkYCEZfKXtCFaa/xI/KZsaOITEcjaJ9NMqWIbe0Ef5C63/GmvsrzQkTMcTvw9F+O+U2yjKhg1PwuR3tGeWYw027etvDe0txPqex0o/cMnyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKcRlBRp; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4750a85a0ddso160241cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741341275; x=1741946075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKx/7WZeBAnXPF4y8oCkUH3yJ/CY8cCFbTvTuih92iE=;
        b=qKcRlBRpzHLPUApiTpdmPyvC+vR5x64cYaEFyjROkard/9J+zQDIQUVc0/KNZU65p9
         cH+SOtFGZ4sCAJ/zaLpGD81Q/wNqkEbG2bT0dD/Y/FGZZbfEQVzBrjqhBK0KbAyhYEwD
         i/P+hr6U7Vhr02KEvmADOFquZ1sB/q3A5aZLxz5recqvMcAAL0bQzVsNN9s5NlNvCiQR
         pTpyt8Q7vVTMMHr0XybP2+Nd50G+JFz8Jqv/+kUammqOuWKY/+RnMFsHFY59NDpqKFwT
         zciz6J6X+AmqD0Kbl6xCDdn8A1HkLByZfEcSFUJoR53fHJZC3+yzFEaSHtChOxzRnSJo
         1LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741341275; x=1741946075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKx/7WZeBAnXPF4y8oCkUH3yJ/CY8cCFbTvTuih92iE=;
        b=ckhwqKR5I7INglhx8YxRVkA9kwq23VSmxtwJuDF/yQoGYtuUJoy9AXEtikeOH5Yg5D
         6BIeT0esk86bvH/sHTcYZuMgXUxX9Gyo9sFgyr3oCIYxxLJUpD6pjoMimWeiE8VjOWXf
         iaig24bcBnKI/a6uCuBqrXgm8Gj0Ikz3Dd0faMXdByuOk+Jg0CYm3LDIUh+u66Iy1Rau
         INiStE8tMIgSwKRREc/mDsLvVjtD+fE5b+7vlsp9tv8+0mp912LJ8/GSb5dQoHHp7A5J
         qh1afRDgHmSW2JYWvzJiud7yYIExxBO7xVysl56xC+QNFnUwyu7eRXz9/Hw0sPKzVl6i
         xGCw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSoc1xAyEoGZt3S1qo4eqo9dvmG8jTXgRk19V1fd5HFr6O83lVn0hR8iy5VjdcQ+iLzCQ9G6bgHMGuEOLAGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCEMPO/W4WtXbFr0lsGOQ6p69C+N+ccSAvkgSbJcCIOEQSyIS
	ChJgo1orV+L/GhtC3m38z7iSkTKkWrfU1lnvTZ4mrt5ZNRi1jCYKDxfE76ParNi8vv0A6IpY+jU
	ai9ilvcG/7xwxMDoGssI8tOM2fVktWAlX2jnl7ejKaQrmBIisAX0V
X-Gm-Gg: ASbGncsq0Qtxb3zpml0osvDoGsF9XpRfjV5huaStaQPOABgF9p31ScPHzrDWiU//u61
	p4VfrAjh294w6IQSRErdW1tkQpddUV0uAuCjlbLf08bdSSFdZNdIcWfOsPzGWn5MUOHQwVV7P14
	5+UfvUC1dKYB6HwgeS0EqavejZwe5wKq3P4sUxL06fkYJIQscEcKGN2JxZ
X-Google-Smtp-Source: AGHT+IHocbYX04XnyKsC1RJwxG/GRnY9nk+ZaOYJZwAitetHw+vWivG5XOzbvlrUcVf71jsz/DdzJdaVcUStr/fGaHM=
X-Received: by 2002:ac8:5d54:0:b0:472:538:b795 with SMTP id
 d75a77b69052e-47621059cbfmr3098391cf.22.1741341274687; Fri, 07 Mar 2025
 01:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306182009.2255241-1-rmoar@google.com>
In-Reply-To: <20250306182009.2255241-1-rmoar@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 7 Mar 2025 10:54:23 +0100
X-Gm-Features: AQ5f1JpaRFS0OagxHIcY7KNQGrxr1iik6OffimOoxb01BkKIkyepohF5FdpbICo
Message-ID: <CA+i-1C2RgoRR-46uD+PBP0N5oLcJYDp05iE96QAXfRRz__e-BA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Fix bug in parsing test plan
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, davidgow@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 19:20, Rae Moar <rmoar@google.com> wrote:
>
> A bug was identified where the KTAP below caused an infinite loop:
>
>  TAP version 13
>  ok 4 test_case
>  1..4
>
> The infinite loop was caused by the parser not parsing a test plan
> if following a test result line.
>
> Fix this bug to correctly parse test plan line.
>
> Signed-off-by: Rae Moar <rmoar@google.com>

Hi Rae thanks again for taking a look at this. I just noticed
kunit_tool_test.py has unit tests for the parsing logic. Maybe worth
adding one for the case that was infinite looping before?

(I am not really able to offer an actual review as I couldn't really
understand the parsing code after a quick reading, but if you need it
then let me know and I'll chase you up to ask questions until I can
follow it, then I can review!)

