Return-Path: <linux-kselftest+bounces-49365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA2D3AB99
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E45C9301276D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13329364020;
	Mon, 19 Jan 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBkLyTHu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0d2pPYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056D376BC3
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832498; cv=none; b=OIrlQoBPm4GWRR1TwStzTe3v3osSWx13bqufouQE7qUrxxE2CcBEhvWclk3o5s7yLxC9biJPu6bw8tCnWLkkB+tqZ2CqMrKNJIpm/vKYCLbKIOTMHHxEtPSFQZqV6pvK5xXjXyCNsLqb4fw6auNAHRRTnkuXsDvENXFzS0ztYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832498; c=relaxed/simple;
	bh=8agNwjJ4zy4m6BRUaQNXinFIwq7siSR4+wJAzG4qWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obBsza+y9K0EAq3MAtf/hmzGwHnuoG+pV6rKFUHwqf+xGvry7xwMaGLxag92AeBcGE7KASCQjKYyW9AhNxUH/j96cg829PiBQVMwxdJN7C8lCWaK0FPRg2/oLM1h+N/GvAEbZsqiPRCWSoYFhWI89j8TFspevF7fUo0ztGXqGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBkLyTHu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V0d2pPYM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JB7HgA1839168
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DUD17svob3ckgQw9sTfdTLObVRKIRVlmGErtozciMyI=; b=MBkLyTHu7KHdVtED
	SgDcrkk5UUan1MrpVDRaT0Hms5z6vq9gbyBcN4LId7jUIF8bDB/rs30a3Gq3xblc
	bs5UK6F2UArgkILogkapp0gL7Thoch2tvUuc4/W1BfNa1ZI+X/wHYHMVXjY5aNxG
	1F081JymlmZx3BgTb93925rQhXZZwjGaJocsBqo5Om9cafW4lDEewc51dm1UfyK7
	wgyZFVR9z98IvALAodPN96IN6dxmZ73ztmF/6fZWZE69W1Hfee2NgT55OwOzOmX+
	PS5x8Yb9rqtVum6jW0KrGkdTHlTr/PJ9g9DjV+e9/efbZWns3PEBt6As7oILNqyp
	/jiESw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskf88ff6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:21:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6ad709d8fso529758785a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768832494; x=1769437294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUD17svob3ckgQw9sTfdTLObVRKIRVlmGErtozciMyI=;
        b=V0d2pPYMb0sYAYzfXBSqxRn/yy8r4aEqDjBNVG11GzIUR70WLD+D2KLHfefpY3nmUk
         0Vo9rif0cPZLzep4A76c0ghpdDRtHjR1M5ESEhJisalhTRpnxw7iR+Ys6v0ANslDM9g+
         e1+zsJMAPCD17VdQHFqxu8jRxi/qnab9NBvrO0lkQ+uCMnJTrHf5p2zrm7AozcJr5FM3
         GCjfsoa/8JywXa2iuQbcvQnhI8hgA1eA2zNRbFtungWteo/ZlpGcnGnODPBZEQa+63UZ
         kduKjwGX86Y3/c6+9jD/GWD1CLv94LDzszun+7T40iAsOQjGHDAxWTzcNhStC/eV2the
         ffTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832494; x=1769437294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DUD17svob3ckgQw9sTfdTLObVRKIRVlmGErtozciMyI=;
        b=vQrqLiqU0h5CPdaHGHHRm7zFQPPfrmAUur8s+g7haQ8NPgy84ELfYa5K8t09255bGj
         HRDJWytwmTYe9Xup4pubwkAdBopTZHTuCq9FeN7zZf4rZK/65dQPdso4iWgqDP42dbqs
         r47n9FuJOyfCqrSTT6tDZbkdQNKHcpON9I1oFN43bxRK0OpkigoFd/3E0ACIYEAx+Sxf
         T7XNqK6FORwJjqVJ4EpF3HGt0rijc0ErRTBjsbNVRfxV8T7T0jJmew8f4bBKsTmgXYjy
         rXB5owpHCmboeGpcPfPuIbmejoSIh9bQvN+a9nm6d+/ny4K/dbPnjz1tFxZvvZ1tPiuW
         xEMA==
X-Forwarded-Encrypted: i=1; AJvYcCUzL/0HBkLpM1dkebgUnNvDiCXgrgJcHCb+uA12+p5tBlnmHUR2vG3OSSzLwSRVycdC4GQ9oH+AfVwsYyk7vzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRACtizwyPnYquB4KrYhtVnljyJzrVKTwNeayMagUCeIPRel6n
	4HoLl8M8dKy6gWt19pVKhNOt3L+zFdg0g7MRvZr6Sw/eJwPBucKXK5uyv9UREHqQkGlOpnIWITq
	n70SJVmAmKlDjg47zBTORnI3kEaGyJzzsmF7rXAWLseU/OKa2gwDywd9o2q4EhbC64bwkC/E=
X-Gm-Gg: AY/fxX592kz+368yVRbfAI7AhcPnBhUiMbMyk/mQ143rchoKEGWU+/cpBNz/p980Fil
	KxFGP618tVE/FDCEEbH6lTJUfFOHLoyun/KwEAUzS5Gf8TA9143EzAhGDy+8HqxfBZC525UWLhN
	eIMYJhnOA1dOb7gXvOZQoPhpx7cYuGfPUaZSdhuTAqrVumtGlOyxkZxD9J1XzATzkYagQwMsnZO
	6MM2W1vWh+jO2s6+giDvv1AIrajRG5elQ/fQXBEvQiHWI9F00+8YBh3osFHmy8WnpiiwtExE7ou
	248yfwDX9DMyu6P5kH8fs9E20eiQNLtMT/bkq1koxRc8mBjTvunOy5iSOXZ/ClkJDSoAVAp5FvA
	/J88Kx2IvyiENn1Xub1PTZnDhE19Jc/fDm2cm
X-Received: by 2002:a05:620a:31a4:b0:8c5:3412:3aa6 with SMTP id af79cd13be357-8c591a1d06cmr1960800685a.42.1768832494313;
        Mon, 19 Jan 2026 06:21:34 -0800 (PST)
X-Received: by 2002:a05:620a:31a4:b0:8c5:3412:3aa6 with SMTP id af79cd13be357-8c591a1d06cmr1960795585a.42.1768832493696;
        Mon, 19 Jan 2026 06:21:33 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8691:997:57af:f0e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c0475sm232136445e9.10.2026.01.19.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:21:33 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simona Vetter <simona.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: (subset) [PATCH 00/23] gpiolib: Adopt revocable mechanism for UAF prevention
Date: Mon, 19 Jan 2026 15:21:30 +0100
Message-ID: <176883238369.34730.6318990234727983164.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
References: <20260116081036.352286-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyMCBTYWx0ZWRfX3u2y9B5LD/xn
 /6lLPoQOaJF9XrQlGTDmQBtVY7msed+fY6lqZe8zQAfZHnSBNm82sFSbIUWuCGJ9nHjFomPEkeZ
 dYLNv5Msc5dhCfI1tguctPafKnOYFMQydLZgQoLQxhzWFDAT6plK4pqPw+uZ7ALJwrG7CpW5uua
 kch9HDbOEsDo1BDZVqbBMBs/jOOhrmv8mdbPqJtP2F9ItwuhJLdliOTYdGTguRdUBGnizE9H1MS
 c/NO4SmZuCnF5VgNUGy5rKsRxJEerQrCC6Hv9t5t71r2EkMxwHz2OrR0uCIcDeKDh04GYdyf/MA
 64NbSiTpHdJwufS70eWCl8Z3pCNO5wp9huhpd4sli4Ae+oK96CG5XDCboSGuAeeMW+qmM1KxSGb
 5pVQ3u1SMKU+EP/ODQ+eoVrjVfO2ncxfCsdCcwkIfZr6kvh6CalizUsDgYodvsK/jiczZxmfcUD
 veuNwQH63dwMRMolzFA==
X-Authority-Analysis: v=2.4 cv=H97WAuYi c=1 sm=1 tr=0 ts=696e3df0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9vGuVDj-4svxC1PVwDYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: U9R0oFBaLxkpFHUwAmL4Z4XG2urChLmR
X-Proofpoint-GUID: U9R0oFBaLxkpFHUwAmL4Z4XG2urChLmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190120


On Fri, 16 Jan 2026 08:10:13 +0000, Tzung-Bi Shih wrote:
> This series transitions the UAF prevention logic within the GPIO core
> (gpiolib) to use the 'revocable' mechanism.
> 
> The existing code aims to prevent UAF issues when the underlying GPIO
> chip is removed.  This series replaces that custom logic with the
> generic 'revocable' API, which is designed to handle such lifecycle
> dependencies.  There should be no change in behavior.
> 
> [...]

Tzung-Bi: I queued these two for fixes. Please resend patch 04/23 separately
so that I can queue it for v6.19 as well. 01/23 and 03/23 risk impacting a
very fragile path in GPIOLIB so any changes to it will have to wait until
v7.0-rc1 to give it a lot of time in next.

[02/23] gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
        commit: be037ec1785d76351037103ce6baddd3299606ee
[05/23] gpiolib: cdev: Correct return code on memory allocation failure
        commit: c7843298bf973d4bc7f4346140661e117186decc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

