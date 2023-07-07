Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0996E74A81D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 02:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGGAbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 20:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGGAbb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 20:31:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656B1992;
        Thu,  6 Jul 2023 17:31:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso920951a91.0;
        Thu, 06 Jul 2023 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688689889; x=1691281889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsL+nUW+0v3XUtpK8KNcb9gGGFha081JmYpkCXmvvAE=;
        b=GXpjwIAvLMq+kyUKw50MZNRwCy+1QvDyjCIT9Vj8bKNYT+3xxDCf34QJQJ4R6cLDap
         I2xZXGYFmyvjSHNE6TFqHbs0KRe9aaFRKNkRXIUUJZ5zzZ12hFb4Vp1gB+DEjcu1qi9i
         j/y7Bjq2SZJTlV6HQFeg78uDrEa2n//VYQTAeeES7sOMoZ0/ECG6Jv3ealK2BAp026/7
         ua5ptOsk1KNNCmKd6zxlFNd4pGVt3TgVf/ANIKMtyPt4cHK9mQqfGBztgHwIFymoq3xV
         wo3jQjh3xphu0RhSBGxDF508bajnYQtaie1/Y4N5PCz9l2Yw10xYS8Kb6W4df4iefmnT
         q+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688689889; x=1691281889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsL+nUW+0v3XUtpK8KNcb9gGGFha081JmYpkCXmvvAE=;
        b=WNpxQlTH9+HDLuEVEojCelgz8quZ/Vqr1xyFxYAVwC+4uCya9LKnWq/ffVEVPQvt5o
         ZomuhySUwvP29z08WoR/klP8ADmj4NI+DbTWz13CPZ2L9GZ4AfqZTvK7P4qrW684L99C
         Le5Ff0sEP6dh44TTP+yp8/aV/mz4F7nd6luASvBcwRaHYncMytPtMM5R+OhYXegexT89
         blnX2BsDwf9Vrh+M3Qd9f9vm/OMRIlbc0LGYCc4ZwpU0dW0Z3IpByM/3v1qTvqswqtbk
         JvKeKSB3UrmBwWY6gYrAn1huO/Un2JdwV9mQ+p6NuFgzYt499xHjK9Hajcrvb3m8BnuM
         ONTg==
X-Gm-Message-State: ABy/qLaUUVtTepzTVoa74l9LKf+Qr/h4FZVr455aTLncgqMyeg1yAR0Q
        Sy+VElVLhX3bVQz97kDT9Zs=
X-Google-Smtp-Source: APBJJlHmGmp/kMMoWIXZOfL5JEIX/ee7sbk/t6Qa4o1H88DgMkVuUNPnFWkk+WVjC8P3Fl0BcPXt9w==
X-Received: by 2002:a17:90a:fe07:b0:262:ca9c:edcb with SMTP id ck7-20020a17090afe0700b00262ca9cedcbmr5574821pjb.9.1688689889483;
        Thu, 06 Jul 2023 17:31:29 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:9b44])
        by smtp.gmail.com with ESMTPSA id gm13-20020a17090b100d00b00259e553f59bsm329275pjb.20.2023.07.06.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 17:31:28 -0700 (PDT)
Date:   Thu, 6 Jul 2023 17:31:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, fw@strlen.de, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netfilter-devel@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] bpf: selftests: Add defrag selftests
Message-ID: <20230707003125.6cxwqev7f5ybjcom@macbook-pro-8.dhcp.thefacebook.com>
References: <cover.1688685338.git.dxu@dxuuu.xyz>
 <deb1c4c5003892997dfb6f628e185b124e590472.1688685338.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb1c4c5003892997dfb6f628e185b124e590472.1688685338.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 05:25:53PM -0600, Daniel Xu wrote:
> +static int attach(struct ip_check_defrag *skel, bool ipv6)
> +{
> +	LIBBPF_OPTS(bpf_netfilter_opts, opts,
> +		    .pf = ipv6 ? NFPROTO_IPV6 : NFPROTO_IPV4,
> +		    .priority = 42,
> +		    .flags = BPF_F_NETFILTER_IP_DEFRAG);

imo the end results is pretty neat. The users would just add this flag and
netfilter bpf prog will see reassembled packets.

The patches look good to me.

Florian,
could you please review/ack, so we can pull them in?
