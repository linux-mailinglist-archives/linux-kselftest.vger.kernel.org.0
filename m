Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E86815F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 17:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjA3QH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 11:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjA3QH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 11:07:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0EF23C59;
        Mon, 30 Jan 2023 08:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7CE5B81253;
        Mon, 30 Jan 2023 16:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C9C433A1;
        Mon, 30 Jan 2023 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675094842;
        bh=X4aq03qfTprEgg2P4B5jLjLns6Z9kMvMXBP08AnjJnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i7O+hF0hl9PK/gRifk/Lx6Cf95CUAHMvtwdk9RQn/pzfwCfJPlwnySra5Tvn/BDb7
         o084qt3maIAsgLnrR5ZjFxF+bowJ/e9Ei99Ni121huFuHnDCSRxbwdQ29OlLwBYmed
         ci7SNMalsdIC3RJtpm7Ba10qAA3jVbbd573BzG35X5rjQsSRIkFwzsWQtg+1r4AM1A
         tsTAcsxHvu8Y5ooCdVpCX/q6fmTRbZi957Zj8yM/5Rt7whyxAW/ngXWouoo/GR+xex
         imwuspjLijKr7Ak+dLBAJYiB5hah1RbhubHp1QRgiqZGwavPUe0Bb5baeOpSBqXmZm
         3d9JEPVDZr5qA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-163bd802238so3421753fac.1;
        Mon, 30 Jan 2023 08:07:22 -0800 (PST)
X-Gm-Message-State: AFqh2kpHI1kLWLnS8uz0E0MM2xYiIneJN9e+UVWjT1xeNx0AcGunMTic
        cBOyHJzZZotJ1b8NwjYGHFahpWWr9lWhLzUuSMQ=
X-Google-Smtp-Source: AK7set/tThFmcDWiZDC78vg3qp3LDXCIDyDuvYxEoearW2/LsbnmuL+8lG7lptjujOfHv7SSHPIU0pJxdMy5lE+Cocw=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr2289709oaf.287.1675094841638; Mon, 30
 Jan 2023 08:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20230130090426.13864-1-likexu@tencent.com>
In-Reply-To: <20230130090426.13864-1-likexu@tencent.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 01:06:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=8Z_-OJdEdUNvUwYpXvWZU7JnYLHW-o+w9GBXjaFbMQ@mail.gmail.com>
Message-ID: <CAK7LNAT=8Z_-OJdEdUNvUwYpXvWZU7JnYLHW-o+w9GBXjaFbMQ@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Keep track of archived files as they are
 added to a new git repo
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Kees Cook <keescook@chromium.org>, Andrew Davis <afd@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 6:04 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> With thousands of commits going into mainline each development cycle,
> the metadata .git folder size is gradually expanding (1GB+), and for some
> developers (most likely testers) who don't care about the lengthy git-log,
> they just use git-archive to distribute a certain version of code (~210MB)
> and rebuild git repository from anywhere for further code changes, e.g.
>
>   $ git init && git add . -A
>
> Then unfortunately, the file tracking metadata from the original git-repo
> using "git add -f" will also be lost, to the point where part of source
> files wrapped by git-archive may be accidentally cleaned up:
>
>   $ git clean -nxdf
>   Would remove Documentation/devicetree/bindings/.yamllint
>   Would remove drivers/clk/.kunitconfig
>   Would remove drivers/gpu/drm/tests/.kunitconfig
>   Would remove drivers/hid/.kunitconfig
>   Would remove fs/ext4/.kunitconfig
>   Would remove fs/fat/.kunitconfig
>   Would remove kernel/kcsan/.kunitconfig
>   Would remove lib/kunit/.kunitconfig
>   Would remove mm/kfence/.kunitconfig
>   Would remove tools/testing/selftests/arm64/tags/
>   Would remove tools/testing/selftests/kvm/.gitignore
>   Would remove tools/testing/selftests/kvm/Makefile
>   Would remove tools/testing/selftests/kvm/config
>   Would remove tools/testing/selftests/kvm/settings
>
> This asymmetry is very troubling to those users since finding out which
> files to track with "git add -f" clearly requires priori knowledge on
> various subsystems. The eradication of this little issue requires naturally
> making git-init aware of all .gitignore restrictions at different file tree
> hierarchies. Similar issues can be troubleshot with "git check-ignore -v"
> for any mistakenly cleaned files.
>
> Signed-off-by: Like Xu <likexu@tencent.com>



tools/testing/selftests/kvm/.gitignore is already meh.

I hope somebody will submit a better fix.




> ---
>  .gitignore                               | 2 ++
>  tools/testing/selftests/arm64/.gitignore | 2 ++
>  tools/testing/selftests/kvm/.gitignore   | 4 ++++
>  3 files changed, 8 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/.gitignore
>
> diff --git a/.gitignore b/.gitignore
> index 20dce5c3b9e0..fa39e98caee3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -102,6 +102,8 @@ modules.order
>  !.gitignore
>  !.mailmap
>  !.rustfmt.toml
> +!.yamllint
> +!.kunitconfig
>
>  #
>  # Generated include files
> diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
> new file mode 100644
> index 000000000000..135d709d2d65
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +!tags
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 6d9381d60172..96561c8e06e0 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -5,3 +5,7 @@
>  !*.h
>  !*.S
>  !*.sh
> +!.gitignore
> +!Makefile
> +!settings
> +!config
> \ No newline at end of file
> --
> 2.39.1
>


-- 
Best Regards
Masahiro Yamada
