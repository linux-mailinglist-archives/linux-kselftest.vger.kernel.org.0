Return-Path: <linux-kselftest+bounces-13366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF892B5CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4442284C46
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E6158205;
	Tue,  9 Jul 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gz+Hyk91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABE157470
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521982; cv=none; b=aPXlUFsreA+Qw3T2UVZn4tSG7+5VveRD+a+7BFEmhNSFLKAv8V0UHW4DNeww3tiXdg5FJebOQEnShKhjs8hht8YzUH8FiTeTjx/8DMx6fbYnKTNCLP0hXZ8GuZzjJ0BPURnWX4C1qhBUqzIAkpOlDcIMyjzF0mEHixGw0htoCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521982; c=relaxed/simple;
	bh=5IA8mdGCfwwEyp51ZU+XuuCLP1hY9Wkb5MGpdFIvwmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xgk6PEzNfLiHezq2xY9RiZhVgIUxmZ3D2NnPDYsssq+cO4NHvMyikjeN5YWlUJWdxKlPjViQNe7JJOnqeNnehsLnaciVa6yIUEAhQV0jjfjudfnFMidRbzCYXkLBu6jFWQb7B6GdH3BQKFyLbKPXDAgr/49Xmq/mhjkG15Y+Ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gz+Hyk91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720521979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GuImmRUsPrPaGPMQUJQBiXamDtmIgFq3/kSekF2cPAA=;
	b=Gz+Hyk916L81Vpv8p1fAMcfGZ1fyLuqp5HPZJm2tIYorFQvt7nMdWhcQaVm4WnlgZPw6jT
	UAVkfhHrtGyIZcoK1IDjLhOMTR2hW0aHeO7boxoDIWPPOLMgZXRYCTxUR+pi33PvXvihMw
	khKJNFaOcYi0zkmY/KSvY5wV7ogWdlI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-34zDYxWUNvi6urTwDB2HRA-1; Tue, 09 Jul 2024 06:46:17 -0400
X-MC-Unique: 34zDYxWUNvi6urTwDB2HRA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367a0030585so155236f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 03:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521976; x=1721126776;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuImmRUsPrPaGPMQUJQBiXamDtmIgFq3/kSekF2cPAA=;
        b=oUQl+OxDgrIgB2rVaF5TbwRmtYspnnlDU2YhQTLUbqf3wFr57OJxxa+mkqPLVscUe2
         oV6xl/tTK7BegC/ykJBrlcSSWCXGhnCUNdm+ilrBs5AX/d84P9cv5ZCP4fYACPgzCJnH
         XbCUAQp6MiiUWfMDGqIJq6HZETEbRq4NY1P+ZjPmI7R91ET/PDVswXE5zvh/uw/AOccN
         djRn3VGI9yA5GDtHl8YIiz7Afdw23J2orLP7o9pxbanByl6EOL61IvBPc6M+FitK8kuc
         UeyA1hlzgEVIDqsFq9XsMth/29HM8sO8rJ5kC87W+tVDe9AHnz0Fm1ZCtAsEENZgNJqc
         kyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7asTUaKlg0F34h91LPltkH0gF0HJy0W1jAtPuLscF2m4YBtxa6vpw/kFr8ScmxFpZskyBaNZS4vVWrbR46WUPzCxAj14Aajpe5ADXMrGt
X-Gm-Message-State: AOJu0YxDuP1ZE2gaKUAgiv8MPDYIeTS+9tw7DADp+eYoeou76rhQGtco
	V1ESKlnBhazud6lClCl+w37QQHrATPSWryvvWwrfjc10lYk0DZKpzvo4Wlo32ikumtWYpIKlh/7
	tbGQ8q36G6/tWUxmWs7bgDVjAGxkwdxJViCaXCboLDYSF8M2C/GMVPEAk7ifrCiOnBA==
X-Received: by 2002:a05:600c:5106:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-426707cee07mr14014645e9.1.1720521976683;
        Tue, 09 Jul 2024 03:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/9nlMV2fi1h21gnXCNPSJp3w9/hO3aQH5rA9bDONuM5D9HIwipNJQ27peTGfgsB2mxMRrxA==
X-Received: by 2002:a05:600c:5106:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-426707cee07mr14014495e9.1.1720521976318;
        Tue, 09 Jul 2024 03:46:16 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427270238a6sm2315325e9.20.2024.07.09.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:46:15 -0700 (PDT)
Message-ID: <b2fe4035eb3b587657442490b1ce8410db63e5d2.camel@redhat.com>
Subject: Re: [PATCH] selftests/net: missing close function in randomize
 function
From: Paolo Abeni <pabeni@redhat.com>
To: Liu Jing <liujing@cmss.chinamobile.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2024 12:46:14 +0200
In-Reply-To: <20240705082421.7061-1-liujing@cmss.chinamobile.com>
References: <20240705082421.7061-1-liujing@cmss.chinamobile.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 16:24 +0800, Liu Jing wrote:
> in randomize function, there is a open function, but there is no
> close function in the randomize, which is easy to cause memory leaks.

Please not that the file descriptor is not leaked, the kernel will
dispose it at process exit() time.

>=20
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/tcp_mmap.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selft=
ests/net/tcp_mmap.c
> index 4fcce5150850..ab305e262d0a 100644
> --- a/tools/testing/selftests/net/tcp_mmap.c
> +++ b/tools/testing/selftests/net/tcp_mmap.c
> @@ -438,6 +438,7 @@ static void randomize(void *target, size_t count)
>  		perror("read /dev/urandom");
>  		exit(1);
>  	}
> +	close(urandom);
>  }
> =20
>  int main(int argc, char *argv[])

This is outside any loop, so the overall effect WRT the self-test
itself is not visible.

I think we are better off without this kind of changes, unless they are
part of a largish re-factor.

Thanks,

Paolo


