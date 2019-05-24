Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD628EE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 03:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEXBmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 21:42:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33433 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfEXBmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 21:42:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so4294041pfk.0;
        Thu, 23 May 2019 18:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GIKdNduKB3cDAE2dm+EnnEet/BY9m5K+nVF4UGBUIzY=;
        b=SrbIe5ALj0T0rXOgWK8xxlmeLBd3tZKpMoDRD1MIrw7os+m+mbIsgfBTr3ydd7t6rv
         b9L9r3EUuGNp8mDETqyABbq4NN5+lwXM6UMnzwoefSHzdE5DSTDh2fnfSKVmoB3zczyl
         NTyPSlt6B6SnS0zaw80X2cUXGnf/3Hie56NguDegWGeIK7Dn+1oBhY4IsTkBCkPP7JSt
         UQTDNk2TaT2hIeUoCIDxEL4E/55YK2i0uJgGIwDhIqjS7Cb0SWJ8YRyOKpFHVpjy7jmi
         7tr1+DbY0T+I25OxStiG0TVsB0QyB+xzM9qGHfQq5Ef5BZk84fVJCqwKsTJijvy1aTuj
         0Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=GIKdNduKB3cDAE2dm+EnnEet/BY9m5K+nVF4UGBUIzY=;
        b=sVsNNVCaPWGXTz++B62uYRbE69SozurJ2K2Scts/V17F3w6owaiDIU8ucNm9xM2UaI
         jnZNCzP02tjyIsnoBiCYcX7MOeYdhEDbA0Ln6CofIarKaZbGe2hHvcw0LtUcn9zKe32t
         ie8AFuDy63J1jLX3ZIgt2H6NggvF0dF7iAo88tqdtT6xr+r/x3vW1GMON7/j8dutasUG
         ycqX51QcBoj7BTaNthNsz1HS0DjYgAb6aMCuf1pYJiUIHbgSMacBSHkUPGufmbuGUxRi
         FuHXyAIa/W+Uf23MvIHkPjJWyaZ5imOFWERU9YCyY0Zuw0YE5YOBl85+cg4mni9c2qa+
         34Xw==
X-Gm-Message-State: APjAAAX/jj3bPsdlL/a8JhKcBVhzxujtbRuDPdwmIScM1sfrqVm4UDb0
        9KqLhLo/WFskaMQWJ9G0JgE=
X-Google-Smtp-Source: APXvYqwWsCeFhr278bXfVFecU1vB7o7KNJSLs+CqU6IF8yOqkwTqxOXtgkUuNQPjJQ0cpcMjhA0R4g==
X-Received: by 2002:a17:90a:2322:: with SMTP id f31mr6098781pje.9.1558662134164;
        Thu, 23 May 2019 18:42:14 -0700 (PDT)
Received: from ip-172-31-44-144.us-west-2.compute.internal (ec2-54-186-128-88.us-west-2.compute.amazonaws.com. [54.186.128.88])
        by smtp.gmail.com with ESMTPSA id s137sm682801pfc.119.2019.05.23.18.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 18:42:12 -0700 (PDT)
Date:   Fri, 24 May 2019 01:42:11 +0000
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: add missing include linux/sockios
Message-ID: <20190524014211.GA78399@ip-172-31-44-144.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Including <linux/sockios.h> fixes the following compiler warning

timestamping.c: In function ‘printpacket’:
timestamping.c:261:19: error: ‘SIOCGSTAMP’ undeclared (first use in this function); did you mean ‘SIOCGSTAMPNS’?
   if (ioctl(sock, SIOCGSTAMP, &tv))
                   ^~~~~~~~~~
                   SIOCGSTAMPNS

Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
---
 tools/testing/selftests/networking/timestamping/timestamping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/networking/timestamping/timestamping.c b/tools/testing/selftests/networking/timestamping/timestamping.c
index 5cdfd743447b..62f03bcc9432 100644
--- a/tools/testing/selftests/networking/timestamping/timestamping.c
+++ b/tools/testing/selftests/networking/timestamping/timestamping.c
@@ -44,6 +44,7 @@
 #include <asm/types.h>
 #include <linux/net_tstamp.h>
 #include <linux/errqueue.h>
+#include <linux/sockios.h>
 
 #ifndef SO_TIMESTAMPING
 # define SO_TIMESTAMPING         37
-- 
2.17.1

