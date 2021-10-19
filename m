Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F19433259
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhJSJiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 05:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhJSJiC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 05:38:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86178C061765
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 02:35:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t2so46669836wrb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L2Opnlu/+Ei1mILrJUudB00wyP5HtEuEpZxkiaGcTuk=;
        b=4Uvv/V9yhjJYTwf+O9NvMcCHZPepWSsWQ2DUG9K7T456ybg9EBcQvphaGM/VctW7mv
         UXLs7h8Sh9o39g1WSMZgTt5pHkZBakrJZqayHGdmOXsrYJlqf7oDOVBbF/EHTSmlOMyM
         a6IlSoE+YWI5Uld+lTvGOg/MOcO72KNwvdOOGLxYL53+KWobDyx1phCv8M3Ok53Efots
         YvjwEjeZ9gSlhjRFgkE+fTmHhQgBNYZ6nIrX6sTpJ0IBFzXwwbDLAglILfPEYJiKXEYu
         1EBw+rQt9324DpZLRV++n8Erlk1/ztmsoKNHHMZ0PnAoOkLDs5PbL0hHWC1QGe2BYPOH
         YB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L2Opnlu/+Ei1mILrJUudB00wyP5HtEuEpZxkiaGcTuk=;
        b=LECZvefl9zOSOXJ+raF2TYuPMYqP2qZ0+EpsYiDIHu+KOiWs63sL0tSt9n6Xe1Rj+q
         kKOTUkiQlwALqs56kcDh03n8PdtEdrO5P6+1q/agAteOuLDI8r/pywaf+6K7r5c5zSGi
         8r8TFaIXVYpzbgERgshc3DNB24OqF28YprxbupbWCX2g4SdAoqQa/06Ve7sAkDWYjrxF
         9BfRME2ljS0cW7TGkQ5E4GOnvwIxys1Kcm2iOtybEKkG7rcknHpb3Hfa8m/4tVUSXQZn
         xdcod09yswcK8essGQa7vvO/pPBVM7E+WqDmgqknpOGle6Fse460+FUA/+a0RQK6WGqC
         2HEQ==
X-Gm-Message-State: AOAM533C2teuaEV/f2ixh/7Ty52RRrVgTofSbyRt/IIp60vKrWcJyaAq
        tj/4y7/wXyk9yatj+WITWJujqA==
X-Google-Smtp-Source: ABdhPJx8VfDG1M08CY2EwW4NlYD+30EjdeM5Y4rFFcgsoqwPfH7CxovxzrJhPB1TEyjaKCuj+tU1uA==
X-Received: by 2002:adf:9b8a:: with SMTP id d10mr40402392wrc.151.1634636148051;
        Tue, 19 Oct 2021 02:35:48 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.82.20])
        by smtp.gmail.com with ESMTPSA id p3sm1727165wmp.43.2021.10.19.02.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 02:35:47 -0700 (PDT)
Message-ID: <e11c38fa-22fa-a0ae-4dd1-cac5a208e021@isovalent.com>
Date:   Tue, 19 Oct 2021 10:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 14/23] bpftool: update bpftool-cgroup.rst reference
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <11f3dc3cfc192e2ee271467d7a6c7c1920006766.1634630486.git.mchehab+huawei@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <11f3dc3cfc192e2ee271467d7a6c7c1920006766.1634630486.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2021-10-19 09:04 UTC+0100 ~ Mauro Carvalho Chehab
<mchehab+huawei@kernel.org>
> The file name: Documentation/bpftool-cgroup.rst
> should be, instead: tools/bpf/bpftool/Documentation/bpftool-cgroup.rst.
> 
> Update its cross-reference accordingly.
> 
> Fixes: a2b5944fb4e0 ("selftests/bpf: Check consistency between bpftool source, doc, completion")
> Fixes: 5ccda64d38cc ("bpftool: implement cgroup bpf operations")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  tools/testing/selftests/bpf/test_bpftool_synctypes.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> index be54b7335a76..617b8084c440 100755
> --- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> +++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> @@ -392,7 +392,7 @@ class ManCgroupExtractor(ManPageExtractor):
>      """
>      An extractor for bpftool-cgroup.rst.
>      """
> -    filename = os.path.join(BPFTOOL_DIR, 'Documentation/bpftool-cgroup.rst')
> +    filename = os.path.join(BPFTOOL_DIR, 'tools/bpf/bpftool/Documentation/bpftool-cgroup.rst')
>  
>      def get_attach_types(self):
>          return self.get_rst_list('ATTACH_TYPE')
> 

No, this change is incorrect. We have discussed it several times before
[0][1]. Please drop this patch.

Quentin

[0]
https://lore.kernel.org/bpf/eb80e8f5-b9d7-5031-8ebb-4595bb295dbf@isovalent.com/
[1]
https://lore.kernel.org/bpf/CAEf4BzZhr+3JzuPvyTozQSts7QixnyY1N8CD+-ZuteHodCpmRA@mail.gmail.com/
