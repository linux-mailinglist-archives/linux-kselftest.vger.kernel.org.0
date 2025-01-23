Return-Path: <linux-kselftest+bounces-25011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43670A1A5C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6BE188C093
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D913C9D9;
	Thu, 23 Jan 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l42QwC+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81E1CA8D
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642784; cv=none; b=A+Ovd0enD9dnaq+TfkfnrZOn9Xw/WtyKaNXCIwCvWfTPfk8BbfMTHL0ABovFs7vXLfmAAlKRCjXadiGqzLqjCsgs7c53VK+GxKXTdxhdlTkLvVNJLwy++5G6r37yrn3oEP3WLajdEdX3HvCRZxbmhzKXYRC3BhaMUvLGgWp6X9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642784; c=relaxed/simple;
	bh=r0Hvdn6xxnSB6hPbB7KW85NdieTAJMCEY/HIdoqyBW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY4LC0g6ZazJ9R3MlLcyrGcmQnCn6K9P8YChkwX/8bRQnwKmOedSI0dDLu91z1/f5OjdZD/7aahfSNF6l2TtJ56WCmSsv9lpkK333rjQnj5DbsZ9WaLnBdsEQx2kJYUWROGL/qJmwLXhuvwAr64rwQJ/TJmUhDKENVNsMLa/ozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l42QwC+4; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4679b5c66d0so209051cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 06:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737642782; x=1738247582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0Hvdn6xxnSB6hPbB7KW85NdieTAJMCEY/HIdoqyBW0=;
        b=l42QwC+4pPO03V9M5sOeU5AJI6UT9lnFCydmsYCtk88xQx6IgryOYGzjSxYYSJgGoU
         24s+x75ZaIB7BLxnztGGa3IY91xTWfhngPcRcB0RhJRv7tEtrQUtXuUJKFlg6GJbuKNh
         6ojr2ffmvGPg7LWKHKvfKkYuCIA7iVicJD9bQH/Q1af5c6+OSHAijxcyhjxiyisSwv7p
         pfe7XV09IlTHQ6Vfxh0ei/Ueung8YchZjizPXV6z8gdAiXQ2RFVGWB/azFNBJdaSFupm
         jgkAiP+bRYuyd0kQ0BOlURxKFQP3/du9AxAgmALIMNVoGdALWQnyaXdwRaBvKS7uTugf
         ohLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737642782; x=1738247582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0Hvdn6xxnSB6hPbB7KW85NdieTAJMCEY/HIdoqyBW0=;
        b=TOnh4ao9sKRggny5qgKdz5k1Id77ziGrDN3eOAcTiFdtHLNk4cdzZ4eZ6Uq85y86vC
         dPwY4UO4MgaIPyD1pg0MRC7wNtvErmK468DSmMz3NBqqN0IqpiXa72foB3wd5choM43R
         eUnj5nu6TydXLkdeUCbGQqXPd9N+wLgUOqC/EKiNReo/PwncSgKBfS44vsJzbfyHaHBC
         RfojNgJQTVb4QT1NQuuGsFTG6gDscpbE7jpdHQAnaW9cqeFMSknh6IgBmGmQL5jKKh0g
         YJypopJgQ3iygkeN8pJtYw1BNxm9sIHrSHifx7MaUb1iXbsW7FrPAEIIT6KL9wtX9cum
         cTKw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ50NF5a7aLuZarpuJTXbK8A+V2Qd+mHhr9XLr2SJNEK0QwzZLfdM2JNMfJqHKHla0DC0zgqcEUv64zy91sac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOb+Dx97FNm5uYmEFBaZ4oU/3EkR7PnJ5vN/mIjRuKXmPIdBRF
	VvKgDPyMEvS4rzqQz2ghXeQOcVmp8GXpcqcpfXaJXFpRBq5YdiTIVVIGlkyTHCttwIMgZqp0NOc
	/vSw3j+rkH65Ag1f1wna6KL+zKjeD7HsgX5sV
X-Gm-Gg: ASbGncuyzqDe10yMfQLMJ/8ZAHc0JNotVpPTo8qdVEH2lG3du2M6wY/ImcQhfV0oU5R
	kPrFIXzZWUjyiyR1tVe3w/0AZensT/9y89jlaWkRYyTXXIr94s7GfaPbPlqbPm6TOnTSPbU6j1U
	CxhueFjLVl0RDW40FT
X-Google-Smtp-Source: AGHT+IFWzAmQRUxSQ8B9nBP+tPYlpG7yjHC9C3ybGoh4CDacV48t3CEb8l0QU5vewcDVF80UbF/wBT/E93jzBnD3GLc=
X-Received: by 2002:a05:622a:138f:b0:466:7926:c69 with SMTP id
 d75a77b69052e-46e5c2110f8mr3963801cf.20.1737642781853; Thu, 23 Jan 2025
 06:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
In-Reply-To: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 23 Jan 2025 15:32:50 +0100
X-Gm-Features: AbW1kvaHGXtKy2YQvSjPJ0e9NNHQvgiBpU3I5IZyxbUGFkYb0Bmb4IRRa3M4oj8
Message-ID: <CA+i-1C0wYb-gZ8Mwh3WSVpbk-LF-Uo+njVbASJPe1WXDURoV7A@mail.gmail.com>
Subject: Re: "stty sane" in kunit.py
To: Daniel Latypov <dlatypov@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 11:49, Brendan Jackman <jackmanb@google.com> wrote:
> Does anyone know what the 'stty sane' invocation in kunit.py is about?
> At
> the time I believed that it was there to clean up after the firmware
> that QEMU runs potentially messed up the terminal.

Came back to this thread to look this info up and turns out it's not
entirely relevant, but I'll dump this info here anyway because I bet
I'll forget and come back here looking for it again, maybe it's also
just interesting to someone here.

The firmware I am thinking of here is SeaBIOS. The best fix for this
is to set `-bios qboot.rom` to just not run SeaBIOS. This also shaves
off some boot time (README[0] says 150ms).

[0] https://github.com/bonzini/qboot

(But, as discussed down-thread, the 'stty sane' is probably not
related to SeaBIOS).

