Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4AA142BBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 14:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgATNGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 08:06:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28249 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727289AbgATNGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 08:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVICxkwYE819T09jumS9b6kqZZVW9alGabNhw2Byv4c=;
        b=bhX7yiQC06ov8M3HpddvHv1pG1e/EwEZ6AzVoYP+YZaot0iUufBUXPWd1c8e7WTe+FmGBj
        HSllop26wd/fEU9wb3SCNorMgXZ+JGdZAJLmxDIbzeDNgMedZR+zw3NS3Awlkhlu2Oe42k
        tuHM1oxS0oGxA5+lE/ec2khu+6SZ1AE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-jxfYp7ZhOXmqOffpz_V1dg-1; Mon, 20 Jan 2020 08:06:45 -0500
X-MC-Unique: jxfYp7ZhOXmqOffpz_V1dg-1
Received: by mail-lj1-f200.google.com with SMTP id z17so7516645ljz.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 05:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oVICxkwYE819T09jumS9b6kqZZVW9alGabNhw2Byv4c=;
        b=ZaNTM7tjFGzkSi+2UQ/KJkgeTXDaD7Y7d/sLDABKkq9smD9cBF2+SV+Lqe83xBnud9
         SNSXQBmUyMiiLwjzHBP0uh01w8VXMAGj6BKEtNndkQQy+vJGYm/D+0xmNJVXoumqi84N
         s3ZlYRvmwWKu9VQey14R5nvNLRLQmKhd7RadrfQnw/qxVuAi5b4B1WmGcbop1JQdsvkJ
         9CqYfpjHuYsqH+gJQslgCEAtmLWua9BYfPrvzSdUXhnExQFOjM+u3KJWtsYb65OWYLP6
         rMt1uFED4d1nu7yVtmaTUEEOv0ZqWrKnQJWlwvZAXLUH5NZgUvWaDUkX0T56fjKDcP9h
         atlQ==
X-Gm-Message-State: APjAAAUivZ8IdX4H5a2pxf4hM00EufJK4P1zYeZyS/yzfWyV+3qH56mU
        JXACaj5vFc7TkYXqIta265YZ/KDCYC9heDYlT0wnolmmfRd7v+gfowrDeKpDgD9CdzihxYVLjAP
        0A/7r9lpbAmhBqLn/+KG07ZV8fmzI
X-Received: by 2002:a2e:9015:: with SMTP id h21mr13901701ljg.69.1579525603444;
        Mon, 20 Jan 2020 05:06:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxl6cjsyjw8Scl4Npe4TQQoKpYIFE7qfthL3twnuQzv1KZL4kmSTEjNXwjKvkvlIou0OEBbwA==
X-Received: by 2002:a2e:9015:: with SMTP id h21mr13901661ljg.69.1579525603114;
        Mon, 20 Jan 2020 05:06:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z5sm16825740lji.40.2020.01.20.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 59E971804D7; Mon, 20 Jan 2020 14:06:41 +0100 (CET)
Subject: [PATCH bpf-next v5 01/11] samples/bpf: Don't try to remove user's
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
        Jakub Kicinski <kuba@kernel.org>,
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
Date:   Mon, 20 Jan 2020 14:06:41 +0100
Message-ID: <157952560126.1683545.7273054725976032511.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
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
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
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

