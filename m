Return-Path: <linux-kselftest+bounces-42851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 122ECBC2646
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 20:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB2EC4E2D56
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3C2E8DF7;
	Tue,  7 Oct 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCH75Zyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFF2E92C0
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862059; cv=none; b=hEAh6S/di2ItSogVUKTkTCAsi6nwjiBU8UICRh/Q+vAbfXty4OBLAEah9P/m5StLQj6v8MoNBCb0HvCmOrW9zadflaYyhMPV5/M/DoZbvA9CeaEgmrb6BQPPk+vec9AlaXzlhFgPNRnlM9u1nXQfuNjhWNxu7tvnkJvTWOhvReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862059; c=relaxed/simple;
	bh=dt4tjYWlWv8x9ZJIQmiQoZ/s2uWP+aNxiQd5ih3f+mw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IpUm3yGJPgOZUGI1VrK4naczlFudUkzeiCYN23bv4dvdJzSSqu8Y4CStN9a4Xce5iIduwrYlm3aKL91hm+ZuEjoaFC9994a/q1bPWFObbYmtAbECbABqwTUl2iH+BVnABuY7Z5+sjQA6RqTOCprJ4g5dkDY5nIxo3sAFUv0kmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCH75Zyp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28e8c5d64d8so64693825ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862057; x=1760466857; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TG0ojd3DpyfQK7Y3Z7Yw/s4AZOM7OqV8GQvLvAagYD0=;
        b=lCH75ZypJvb2Kxj606Uer/iUjF57n+2Ndvd7RhNEy4BtDmT+LiJlC/w+ZEEFvnV0Ig
         6Jp8i9VzlC5Hx2lcHP+2IcINiLG80Aka6G/D4AmOkfNDBoHr0L8j41K38re6udXFtEjy
         qRnjgOc4pNJkiRBBQMmEvZpU11pIh6u5L8Xz+11PW/nb50D89BYZ+zU2L7i0mRFGPTwi
         +DOkLNtX5Yfm6fOlyr03hPNsohOWycO4h90FYvUjYOnpM2u9ZF8/W0NANPTVWTPvv/0X
         S/m0vcanpjaCorbwqQOuqeB1y0eP/Od28F/PrdAQx63CKqyuBmDnBtSPtZ/5pHITABk2
         /dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862057; x=1760466857;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG0ojd3DpyfQK7Y3Z7Yw/s4AZOM7OqV8GQvLvAagYD0=;
        b=WbljNKQx+98+NvaoU2HIVHlTtIOW+r7WYLTw6bByfNJuT+zwcP2XVSEjj2fo9oAmP0
         hQsOprz7j1BXFJNvleHV4mPlA9kr/b5Rqq95L5e/A+55FFDUuDlcudGyL9nU2f/D1eFP
         +JLh/QoTEaDOvOOUuhLpK8iswT3MMhq/FEi/9ytDeEPGaQV+i6gKJe2maP0F7Mv+rN7L
         qfQyM14A2ZVLWMvIm3+2QjKS+yl+VBC5jk9Pw3jaDL1sCroAAZA+A4vF0DZ0dheBd/jz
         42yEhSWzvJagEyZuziGTms6jub4DVnxKps26OHY07RNQKMJBJv5uS+xcOoJsfv18nCvj
         4/ow==
X-Gm-Message-State: AOJu0YwebT0ol1JMcheXAWclhyhzNXxAZtSlDXUFttWWktbUpLjHgmyU
	Ke1I9xT+CK97lwcP1PWAAPdbCFYl/KzZky20HssCCGWdcu4GcowXOWWRLiOplzW1v5wqe4o8mZn
	wCk1D/G6qZyTmv0LULaLFP+EINy278uh1kqig5IE=
X-Gm-Gg: ASbGnct++42O8znCYKZ5odRXCcPhcxT6/ruBTAG4UUS7mappsm2qWha7DHN77oCNZaR
	Oyvxs6I2FmlAP7GEqh6Omyi5CDK9J5qlT4k+QDnt+SAT4eIg5A5oLiJx0MpINUNG3PQbrPpPGp0
	sss1sdq+YvSCT7gsp0o58pj7bXuG//CD93c5XgcBU2IYILt2HQ+qDYV0jSBfar4CvhSkEXRadtQ
	D5/Xb2jHOoUPvmUHOvh8jcEaf/RaOSXA4iY07GOZzM=
X-Google-Smtp-Source: AGHT+IHweQjFsWLhMrQ6rp0nQ3CPoz5ngY7IO4RU6lr3LhjnvK0p0uAyxRWLfioJVOfuyRR9Pt3yHH5n4NVpIYBn9JE=
X-Received: by 2002:a17:902:ea02:b0:280:caeb:ed67 with SMTP id
 d9443c01a7336-29027384f4fmr8130745ad.23.1759862056764; Tue, 07 Oct 2025
 11:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Melezhik <melezhik@gmail.com>
Date: Tue, 7 Oct 2025 21:34:05 +0300
X-Gm-Features: AS18NWCBseyVFlhjDtlxflfuXiNCQce5suNSZ94ZqOshlsMdkaMNFPJ7PVlexZs
Message-ID: <CAL7UUk-Yrw=n-wQ_2E8vs70XmcB7mWzLgQc7diTgo97unVXY1w@mail.gmail.com>
Subject: Run selftest via web server with UI on localhost
To: linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! I am kind of a newbie here, no experience in kernel development
but with decent experience in QA automation and automation in general
. What about giving a user an ability to run selftest tests in
localhost server via web server with UI. I know many things are
customizable via terminal with current setup however the UI approach
might have some benefits :

- processing raw KTAP output in nicer and more human readable way
- having build step and test step as separate reports
- having running/installing  kernel ( which is tested ) as separate
test/report
- automatically dump server environment in case of any errors ( good
input data before submitting bugs )
- automatically installing dependencies required for specific
environment ( all this foo-dev packages )
- allow user split tests into different groups ( based on existing
self test runner capabilities) and thus generate separate browseable
reports
- run long running tests in background with possible job termination via UI

So it=E2=80=99s all about convenience and more easier way for QA people to =
do testing

I see it as a good option, using current terminal run flow as a default

PS if people like the idea I can come up with some prototype in a
separate patch , I already have some tools in minds ( some of them I
am author of )

Thanks

Alexey

