Return-Path: <linux-kselftest+bounces-18354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E703B986017
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F541C261DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BFF1BAEEA;
	Wed, 25 Sep 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ0VksGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6C1AD9D1;
	Wed, 25 Sep 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267051; cv=none; b=WhnDM9ueU3PhENABcwEmTZusTB4pExlbYsPFzJZ/3S1+A4hvtkL56iY9zzU3SficfSBb/b0T4mSP2+nVE6a6FyFwlfNvuNMeIjtXOvLIUhcqJfyVCFK+aLkWqaqJAVoewiHeG9FJaIUgAqWehGNgb5BT0AAsbRKmmwA9TdbwPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267051; c=relaxed/simple;
	bh=7IW7RTcLpOgxZZP501qb1vVbPlEm3RjQ1ux8c067MVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8k5/FdMxSB3f5mqt+zUOhsXJFp1LOx7ybr//Dhw4M2L9u61knzvPbpurcTP6BpyfMzwVfyS9I0YtzAHDzO739L3UPbXIvca3qB/lmnE3lQ8CRKtw6sguDYk4j0fNH6L0mw8QysWgGh//zfEOZPrlLpCTBuUs33CQXQG+bJiKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ0VksGw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93a1cda54dso110514366b.2;
        Wed, 25 Sep 2024 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267048; x=1727871848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lsxEOCwsoXbFkn1yMDzhagn4UCZ4K4wi9PS2Tk4cfw=;
        b=iJ0VksGwxXA0GAnHfAO5Hx1mNeKsJEIjKk4T9tD1N9TGRsuXkth5yuJcGg/MLYJJyx
         3WsUtRrmLaqYJYmm6rU7F3DZ4iAFIPU9KH8scgvnmfw8J+uefWLP+VJHPKAWcl7IOAyh
         fzNOjSU81aNStFiY66Nvpi2ThJFmWQk0ROqnx5gXAU3BQzgWml+Zf2JpYAyAMX85ndiC
         HMSThbdiE+Meqb/Db6gExaFUMZ6BFTa+rkB9cRjnZdf0uMMWTRP5FhuBP8AVOY0eN9Wx
         58+H0x8PBMgiExYcf9Dmr5fPOasYYb2RQS/MDl1QNGpfzg2lMDn5oKHq76smPXqh7B3D
         hG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267048; x=1727871848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lsxEOCwsoXbFkn1yMDzhagn4UCZ4K4wi9PS2Tk4cfw=;
        b=uXtWiUEBeiWiSu2nHeKyvC3xDljKKoMpcWIUhMnYAcXnRqONP482moTysx1o/bzqnh
         A2Q0qbY+oVUHtiAIzQrjIm5LfTr62jkrByw2FkDgp3RBF9rPYqizFAI+GjGg6rWa96QS
         3s4q5OROIQD0Yhlspk8bQ9WFUW+ltSkA8v3ol8ftECutlSRl0Qa3IhRNhtyvt3nuWit0
         /Di3/igLZk3v61IqXMtIkuDUBxf/4AHGsLbQzc4hHnsIUVDohBXQAOFv3rfAZdCIOhpl
         U+NuNA13iKj0oUJ5oigYFHF72BfEvDHFqBjkZx7kRENjEl5/x6IPZHsBoDqnDf+5pbq8
         zJAA==
X-Forwarded-Encrypted: i=1; AJvYcCU+YXcmMmmhpEthIkUH+zc06e8wK7Inr3SXaejMcwi17rMG2ZJsJo5BOYWHzrCUzTfLDsH8YKRi@vger.kernel.org, AJvYcCVEqXm5opib6G6ZN7NIKNsT0J2D9lTxqBN6ejqfKkIwqxn6gmIVedWnQ4hdT5iGYUnbC8xaf+OIWE507jY=@vger.kernel.org, AJvYcCX8JGWRze/N3cQptYQ7IHZ2QW7BiRC0O7Z/p8IG9uTeQ+u/evru05Czj2TtXYeAfgrQLfH4497qITgJpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhS+FooCak56RHebhmp0zeMk6+nqubpebZktlwxCqYXvG4a2Z8
	PMNog2ruwiy1jOgHXX9OytXQEzx/WzdEKnU0Oij4HoqmdKZE5Kv5XgJf9k6r
X-Google-Smtp-Source: AGHT+IE4F7MIDE3gwFeysvFqd14Ezun9YWADHyABgtnmSAAaZD5uc9HiNFKlc7yZ3pZl3TekZbH5og==
X-Received: by 2002:a17:907:3f22:b0:a91:a5f:c9ce with SMTP id a640c23a62f3a-a93a0678b45mr199090966b.62.1727267047542;
        Wed, 25 Sep 2024 05:24:07 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8529sm204745566b.185.2024.09.25.05.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:24:06 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 14:23:47 +0200
Subject: [PATCH v2 4/4] selftests: exec: update gitignore for load_address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v2-4-bbbbdef21959@gmail.com>
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727267039; l=863;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7IW7RTcLpOgxZZP501qb1vVbPlEm3RjQ1ux8c067MVg=;
 b=v8ert1fyzU29Kss8HWM/CpR6nWddO6lRb1LJMQ2XTPCGjiku6Fddv7JlMSDP/OQatWPfTnZTB
 xjcWVveyjUXDVsdPiKSJhTEoqD4HbeAol+FD7G3Qdu2pBkQaV63S1jk
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The name of the "load_address" objects has been modified, but the
corresponding entry in the gitignore file must be updated.

Update the load_address entry in the gitignore file to account for
the new names, adding an exception to keep on tracking load_address.c.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/exec/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 90c238ba6a4b..a0dc5d4bf733 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,7 +9,8 @@ execveat.ephemeral
 execveat.denatured
 non-regular
 null-argv
-/load_address_*
+/load_address.*
+!load_address.c
 /recursion-depth
 xxxxxxxx*
 pipe

-- 
2.43.0


