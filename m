Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125077ED7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 00:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbjHPW5e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbjHPW5b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 18:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA92698;
        Wed, 16 Aug 2023 15:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983E5647E9;
        Wed, 16 Aug 2023 22:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B48C433C8;
        Wed, 16 Aug 2023 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692226649;
        bh=yYTCJSHKsQ+dHxVY+jZwCxQdt2vj5Cs53HcdgRkS9n0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q6/+N5/2K0alaUvfFZKpLkyus02mepGXBSMW38/YPkVTebOoDZchfDEcYGS4wrb/p
         VPU5Jw9mznK5fPBKFCldUwrwZVB/wJTc5FrMdeiU5QZD320jMDuGglsVvy6wfu511o
         uPDX6y3eZzC7rkYbZKP2jApp16mPCfN1PyPo+mU8ceLxQeCPjswIG+CIlCjDVYjD0+
         ChGORRyZSe3NBjrbwT/7LUMBk1jEWMlidpzJjGQBTP7pEqwWtYiellXjyvkQbIpnzS
         XpUiacVCZc5tem0PR1FsSDjtfWWrJLxQRXu4HWftegfPp68Ro62fn153cnNrT6GUJs
         OhCsi+LvLrdxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E237CE0593; Wed, 16 Aug 2023 15:57:28 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:57:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] rcutorture: Copy out ftrace into its own console file
Message-ID: <6a234118-1ad2-4e22-ad80-f35a1dab8f03@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230815190949.GA3207581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815190949.GA3207581@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 07:09:49PM +0000, Joel Fernandes (Google) wrote:
> When debugging, it can be difficult to quickly find the ftrace dump
> within the console log, which in turn makes it difficult to process it
> independent of the result of the console output.  This commit therefore
> copies the contents of the buffers into its own file to make it easier
> to locate and process the ftrace dump. The original ftrace dump is still
> available in the console log in cases where it is more convenient to
> process it there, for example, when you have a script that processes
> console output as well as ftrace-dump data.
> 
> Also handle the case of multiple ftrace dumps potentially showing up in the
> log. Example for a file like [1], it will extract as [2].
> 
> [1]:
> foo
> foo
> Dumping ftrace buffer:
> ---------------------------------
> blah
> blah
> ---------------------------------
> more
> bar
> baz
> Dumping ftrace buffer:
> ---------------------------------
> blah2
> blah2
> ---------------------------------
> bleh
> bleh
> 
> [2]:
> 
> Ftrace dump 1:
> blah
> blah
> 
> Ftrace dump 2:
> blah2
> blah2
> 
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Very good, and I did queue this one.

I fixed the indentation of the awk script.  Perhaps your text editor is
being too smart for our good?  ;-)

							Thanx, Paul

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
> v2->v3: Updates from Paul. Also handle multiple ftrace dumps.
> 
>  .../selftests/rcutorture/bin/functions.sh     | 24 +++++++++++++++++++
>  .../selftests/rcutorture/bin/parse-console.sh |  7 ++++++
>  2 files changed, 31 insertions(+)
>  mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> old mode 100644
> new mode 100755
> index b8e2ea23cb3f..a5c74e508e41
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -331,3 +331,30 @@ specify_qemu_net () {
>  		echo $1 -net none
>  	fi
>  }
> +
> +# Extract the ftrace output from the console log output
> +# The ftrace output in the original logs look like:
> +# Dumping ftrace buffer:
> +# ---------------------------------
> +# [...]
> +# ---------------------------------
> +extract_ftrace_from_console() {
> +        awk '
> +        /Dumping ftrace buffer:/ {
> +        buffer_count++
> +        print "Ftrace dump " buffer_count ":"
> +        capture = 1
> +        next
> +    }
> +    /---------------------------------/ {
> +        if(capture == 1) {
> +            capture = 2
> +            next
> +        } else if(capture == 2) {
> +            capture = 0
> +            print ""
> +        }
> +    }
> +    capture == 2
> +    ' "$1";
> +}
> diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> index 9ab0f6bc172c..e3d2f69ec0fb 100755
> --- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
> +++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> @@ -182,3 +182,10 @@ if ! test -s $file.diags
>  then
>  	rm -f $file.diags
>  fi
> +
> +# Call extract_ftrace_from_console function, if the output is empty,
> +# don't create $file.ftrace. Otherwise output the results to $file.ftrace
> +extract_ftrace_from_console $file > $file.ftrace
> +if [ ! -s $file.ftrace ]; then
> +	rm -f $file.ftrace
> +fi
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
