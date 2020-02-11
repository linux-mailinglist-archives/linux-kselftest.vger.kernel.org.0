Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668CD1586CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 01:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBKAb6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 19:31:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBKAb6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 19:31:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so4771077pgk.7
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 16:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTD7KLfgNlcO5TldUCo2W66GWZWNBDU2Nh1U6Y8rvDo=;
        b=uaAIWqJSfi6jxhANMhO9SKzdRBl4fHthnjWBFFYu3OqcCXlHg6vW5P5ib6vXtuAGe6
         SN/QoxaUKMIuIzydImDfxngn+9IM7BhNHpLF9IShTGKsW/y/CNBmOVvwdeN8lSOpjI3O
         EETr6cBMC5FY842BDbMARD6y/hQk7qo3cejZZ4yJU9llGfdM5JnVhqjTMTVRlGK8AiCj
         endtjwPanzcbc2W7vUuVlvr1+twK+7FruGCpxmgNGkYTXLo5ZYqYcFkXyOEmOxnlJl4h
         puzWKjvrHge400ZoAm4U4N7LM6gaO5IYSbDWmffefI9EbW8xzdtZxyABeGxC5HVCvx2E
         7BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTD7KLfgNlcO5TldUCo2W66GWZWNBDU2Nh1U6Y8rvDo=;
        b=d6JB0UoK3hGyFKlJEskTlAKkhHlHUWS6/RuGE7DP42Bp+pA1N8zAOk9+Md1vxOLbEJ
         dlDdVIy3VArtoe+EiaX9/ytrEfan8J6EAsk1xRFKOtibtwYCnZ8gasBBuqlZo99brq5x
         QF66aOe7EU5VKopYoukEDAHYcVEmLyD86xU+rUlsLCZSE8BaiZbJUI/k5dJu0xVMJY80
         XdCKoerkjZ/HnC9lZsxcMQYB8ERJCeFLPQG8X3VMILlzYx3zMDt2uVPC7e0CmC8nWnNQ
         dq+noAu1y4myC5IPy9PcSehB2pjnzZHRTqa4jRqt6AkAQ7+erl1yEvDMk2u4hOtF3pZu
         G82A==
X-Gm-Message-State: APjAAAUHFyCnaJyRC6Nt+6OYEw4J9SgJdYaLgyaIgEAz97P+I6HSNToN
        lLy/OZ8trg8NIcC2bHzwcTx+cQ5ZAvxUZkQVLeh4eg==
X-Google-Smtp-Source: APXvYqxCPd6IWyA7i0kDa518+F/G8kcxtU076GQepHtqKvT8oL022G2nN2ShfFGtfUu5HehartnyNC29u/fMc6B4eSw=
X-Received: by 2002:a63:480f:: with SMTP id v15mr4118291pga.201.1581381116183;
 Mon, 10 Feb 2020 16:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20200211002551.147187-1-heidifahim@google.com>
In-Reply-To: <20200211002551.147187-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Feb 2020 16:31:45 -0800
Message-ID: <CAFd5g47LFvRxHMJ+XHcw2dFe2xU+1GmDnXsm=STvCFAT74rm7g@mail.gmail.com>
Subject: Re: [PATCH] kunit: run kunit_tool from any directory
To:     Heidi Fahim <heidifahim@google.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 10, 2020 at 4:26 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Implemented small fix so that the script changes work directories to the
> linux directory where kunit.py is run. This enables the user to run
> kunit from any working directory. Originally considered using
> os.path.join but this is more error prone as we would have to find all
> file path usages and modify them accordingly. Using os.chdir ensures
> that the entire script is run within /linux.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

> ---
>  tools/testing/kunit/kunit.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e59eb9e7f923..3cc7be7b28a0 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -35,6 +35,13 @@ def create_default_kunitconfig():
>                 shutil.copyfile('arch/um/configs/kunit_defconfig',
>                                 kunit_kernel.kunitconfig_path)
>
> +def get_kernel_root_path():
> +       parts = sys.argv[0] if not __file__ else __file__
> +       parts = os.path.realpath(parts).split('tools/testing/kunit')
> +       if len(parts) != 2:
> +               sys.exit(1)
> +       return parts[0]
> +
>  def run_tests(linux: kunit_kernel.LinuxSourceTree,
>               request: KunitRequest) -> KunitResult:
>         config_start = time.time()
> @@ -114,6 +121,9 @@ def main(argv, linux=None):
>         cli_args = parser.parse_args(argv)
>
>         if cli_args.subcommand == 'run':
> +               if get_kernel_root_path():
> +                       os.chdir(get_kernel_root_path())
> +
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> --
> 2.25.0.341.g760bfbb309-goog
>
