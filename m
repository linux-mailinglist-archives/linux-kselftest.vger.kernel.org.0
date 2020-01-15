Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A046613C51A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgAOOM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 09:12:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgAOOM4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kZC7agzU6ERgvosRoOEsIt+SJXOB994svdT5EEHwwQ=;
        b=UTnR3IGZ0XZql1BQOK2y2d3I3WZdNg1U24+Lzd0fDR9QWyfwvGtY9stnJ64uvhRGzrLQJ3
        tnC6QYi2JXV7Fm6wnnKhR3uNPhYJjz1KDN+kmDdYenQleanBeuEXc7TyYLyIyIf0b+Gk2E
        3j38/fNPgz2obDBG9O/mLn6K0PMgSfk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-l9DJ6anzOBWYKdjcrXn8bw-1; Wed, 15 Jan 2020 09:12:53 -0500
X-MC-Unique: l9DJ6anzOBWYKdjcrXn8bw-1
Received: by mail-lf1-f72.google.com with SMTP id v10so3251613lfa.14
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2020 06:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5kZC7agzU6ERgvosRoOEsIt+SJXOB994svdT5EEHwwQ=;
        b=SoHNpXLbOmNVUDHphdNAlurBCdNtZUvee0KfZuBeTx+L9WqKNCDPjRd5t8IpqlBNeI
         eHILCSurmlttjhNrF7cPp/ApJ/5DJ+oMo9eE5Jf8p5V+45CDhvJdBIumZ0XsfQc2gcVo
         pI1ecomjzt3oTcB9WZfcUE/xO/oAdYRpBH2DzvBoKWP+j9DBdTsrLS1Hbeake7QwzUxd
         SDH8BB8JOMLOXjfAqK3wPb05jwfkKK72/NgXNgbfgo3sMniUsNAO8IsdKuu0WWO/VjmQ
         7iUMXr/Rr2EY1Gv1E97jM2vGGw0+mRldbVIQ/usPbRvbuz9jABND+4WFRENdu0p7W/mz
         rD1A==
X-Gm-Message-State: APjAAAVS1LORVoCbKZnstaquWKGA0wblAcqVfD5866SQfiHyX7dMrQop
        2QzHd1PeTyU/4TTXWPG0SIabKsWeiiK1KvlM5wqBOhT2S1HyxX7bojM/jrkAZGjGvvegsja0tLj
        T5e+KCwZexXZ9GzyO/RQroSWnSdpQ
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr1780372ljo.125.1579097571920;
        Wed, 15 Jan 2020 06:12:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyuoOjc+eVP5Ci0BzdoyleP1ltz4n/QthZHzLyJz+nAamj3hS1TdOZkbCInbJ5A/OXc+hTog==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr1780322ljo.125.1579097571478;
        Wed, 15 Jan 2020 06:12:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m21sm8930987lfh.53.2020.01.15.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D8D8E1804D7; Wed, 15 Jan 2020 15:12:49 +0100 (CET)
Subject: [PATCH bpf-next v2 01/10] samples/bpf: Don't try to remove user's
 homedir on clean
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 15 Jan 2020 15:12:49 +0100
Message-ID: <157909756981.1192265.5504476164632952530.stgit@toke.dk>
In-Reply-To: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The 'clean' rule in the samples/bpf Makefile tries to remove backup
files (ending in ~). However, if no such files exist, it will instead try
to remove the user's home directory. While the attempt is mostly harmless,
it does lead to a somewhat scary warning like this:

rm: cannot remove '~': Is a directory

Fix this by using find instead of shell expansion to locate any actual
backup files that need to be removed.

Fixes: b62a796c109c ("samples/bpf: allow make to be run from samples/bpf/ directory")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 5b89c0370f33..f86d713a17a5 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -254,7 +254,7 @@ all:
 
 clean:
 	$(MAKE) -C ../../ M=$(CURDIR) clean
-	@rm -f *~
+	@find $(CURDIR) -type f -name '*~' -delete
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like

