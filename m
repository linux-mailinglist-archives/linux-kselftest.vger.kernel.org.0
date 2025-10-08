Return-Path: <linux-kselftest+bounces-42868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A8BC441E
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 12:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F88E3513D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A052F531C;
	Wed,  8 Oct 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae0QvNax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6A221FBB;
	Wed,  8 Oct 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918180; cv=none; b=gfIzwFDDfMAVI9mLrLuhcprd4P6dvNSWpOubx4ZHCm7dhXJu40ZkKVm09i51av89U4xyMimxrxoFF9n3Ad3nf6ab6iJa1sTtXg88wbZ2P4WtL0MDhdCrQ87XdRQ873GgAzIXhnEdnzGEPzt3j9IyOGXb9ctVwwVXA93aOSsbylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918180; c=relaxed/simple;
	bh=hH5mbS/i6SnetVEpBGXLDwHNIj2omM4QhA8WO03ybls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bwnvxqLBpNyQbKAnI5VC/bchI6DqjganDng1vKB30FuOJLhC1SlKaovZyPE0vA8qc2PQ7Mty04IDJxWjUW0LUDNBVNUGK0D4aPLszr278DiYrh3cwQLfNHgqq6FqtKE0mk172oq8U348426QE2hmqMVft8g8xdOulZNmB1TysUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae0QvNax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1147C4CEF4;
	Wed,  8 Oct 2025 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759918180;
	bh=hH5mbS/i6SnetVEpBGXLDwHNIj2omM4QhA8WO03ybls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ae0QvNax/Gh4sEm/JPltRjXqVkzIsM/OkmTqTojsV0Fzr4j1dOvnOu/vLNB+TwHJj
	 q6v1/e69VnypbSZe878SXf6wdPuzbcSsJCwhvmfbiM9b19SgxCDjOTKsB4MajwL5eo
	 Px7FBFA4JZYqCoazXdtIzSFM3j0K5gBn5QV+OyOZAwJVnEWREus6zCmHXGAKNVBiAp
	 9Q8Z4r0BOLYczGnwWJCbvH7OwxIqFGsSIXIeN9KTHwVYy0VJlzD2hE9rfgOXWkO39p
	 jZhIpgN9EjUx0RHxXaoP4nzZfsiWljKDM2mhH3LzhUc7I+XCSmBeDGXICAHqxXkLm+
	 n3IHujCzjW/PA==
Date: Wed, 8 Oct 2025 19:09:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 hca@linux.ibm.com, corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols
 and :entry/:exit
Message-Id: <20251008190937.c7c992e41b4397fecbc8176e@kernel.org>
In-Reply-To: <20251004235001.133111-4-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
	<20251004235001.133111-4-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Oct 2025 08:46:57 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

Please describe what this patch adds, for what reason.

> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>  kernel/trace/trace_fprobe.c | 247 ++++++++++++++++++++++++++++--------
>  1 file changed, 192 insertions(+), 55 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index b36ade43d4b3..ec5b6e1c1a1b 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -191,6 +191,9 @@ struct trace_fprobe {
>  	bool			tprobe;
>  	struct tracepoint_user	*tuser;
>  	struct trace_probe	tp;
> +	char			*filter;
> +	char			*nofilter;
> +	bool			list_mode;
>  };
>  
>  static bool is_trace_fprobe(struct dyn_event *ev)
> @@ -203,14 +206,10 @@ static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
>  	return container_of(ev, struct trace_fprobe, devent);
>  }
>  
> -/**
> - * for_each_trace_fprobe - iterate over the trace_fprobe list
> - * @pos:	the struct trace_fprobe * for each entry
> - * @dpos:	the struct dyn_event * to use as a loop cursor
> - */
> -#define for_each_trace_fprobe(pos, dpos)	\
> -	for_each_dyn_event(dpos)		\
> -		if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))

Why remove this? This is for finding all fprobes.

> +static struct trace_fprobe *trace_fprobe_from_dyn(struct dyn_event *ev)
> +{
> +	return is_trace_fprobe(ev) ? to_trace_fprobe(ev) : NULL;
> +}
>  
>  static bool trace_fprobe_is_return(struct trace_fprobe *tf)
>  {
> @@ -227,6 +226,109 @@ static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
>  	return tf->symbol ? tf->symbol : "unknown";
>  }
>  
> +static bool has_wildcard(const char *s)
> +{
> +	return s && (strchr(s, '*') || strchr(s, '?'));
> +}
> +
> +static int parse_fprobe_spec(const char *in, bool is_tracepoint,
> +		char **base, bool *is_return, bool *list_mode,
> +		char **filter, char **nofilter)
> +{
> +	const char *p;
> +	char *work = NULL;
> +	char *b = NULL, *f = NULL, *nf = NULL;

See below (out: label)

> +	bool legacy_ret = false;
> +	bool list = false;
> +	int ret = 0;

nit: sort local variable by line length. (longer to shorter)

> +
> +	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
> +		return -EINVAL;
> +
> +	*base = NULL; *filter = NULL; *nofilter = NULL;
> +	*is_return = false; *list_mode = false;
> +
> +	if (is_tracepoint) {
> +		if (strchr(in, ',') || strchr(in, ':'))
> +			return -EINVAL;
> +		if (strstr(in, "%return"))
> +			return -EINVAL;

It seems below loop checks all above cases.

> +		for (p = in; *p; p++)
> +			if (!isalnum(*p) && *p != '_')
> +				return -EINVAL;

This only allows that the @in must be a symbol name.

> +		b = kstrdup(in, GFP_KERNEL);
> +		if (!b)
> +			return -ENOMEM;
> +		*base = b;
> +		return 0;
> +	}
> +
> +	work = kstrdup(in, GFP_KERNEL);
> +	if (!work)
> +		return -ENOMEM;
> +
> +	p = strstr(work, "%return");

Note that strstr does not care it ends with given string.

> +	if (p) {
> +		if (!strcmp(p, ":exit")) {
> +			*is_return = true;
> +			*p = '\0';
> +		} else if (!strcmp(p, ":entry")) {
> +			*p = '\0';
> +		} else {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	list = !!strchr(work, ',') || has_wildcard(work);

Wildcard is OK for legacy.

> +	if (legacy_ret)
> +		*is_return = true;
> +
> +	b = kstrdup(work, GFP_KERNEL);
> +	if (!b) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (list) {
> +		char *tmp = b, *tok;
> +		size_t fsz = strlen(b) + 1, nfsz = strlen(b) + 1;

size_t fsz, nfsz;

fsz = nfsz = strlen(b) + 1;

> +
> +		f = kzalloc(fsz, GFP_KERNEL);
> +		nf = kzalloc(nfsz, GFP_KERNEL);
> +		if (!f || !nf) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		while ((tok = strsep(&tmp, ",")) != NULL) {
> +			char *dst;
> +			bool neg = (*tok == '!');
> +
> +			if (*tok == '\0')
> +				continue;
> +			if (neg)
> +				tok++;
> +			dst = neg ? nf : f;
> +			if (dst[0] != '\0')
> +				strcat(dst, ",");
> +			strcat(dst, tok);
> +		}
> +		*list_mode = true;
> +	}
> +
> +	*base = b; b = NULL;
> +	*filter = f; f = NULL;
> +	*nofilter = nf; nf = NULL;
> +
> +out:
> +	kfree(work);
> +	kfree(b);
> +	kfree(f);
> +	kfree(nf);

Instead of using goto only for kfree(), use __free(kfree)
to clean those up automatically.

> +	return ret;
> +}
> +
>  static bool trace_fprobe_is_busy(struct dyn_event *ev)
>  {
>  	struct trace_fprobe *tf = to_trace_fprobe(ev);
> @@ -556,13 +658,17 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
>  		trace_probe_cleanup(&tf->tp);
>  		if (tf->tuser)
>  			tracepoint_user_put(tf->tuser);
> +		kfree(tf->filter);
> +		kfree(tf->nofilter);
>  		kfree(tf->symbol);
>  		kfree(tf);
>  	}
>  }
>  
>  /* Since alloc_trace_fprobe() can return error, check the pointer is ERR too. */
> -DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_fprobe(_T))
> +DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *,
> +	if (!IS_ERR_OR_NULL(_T))
> +		free_trace_fprobe(_T))

OK, it looks good to clean up. But please do it separated patch.
Do not touch if it is not related to your change.

>  
>  /*
>   * Allocate new trace_probe and initialize it (including fprobe).
> @@ -605,10 +711,16 @@ static struct trace_fprobe *find_trace_fprobe(const char *event,
>  	struct dyn_event *pos;
>  	struct trace_fprobe *tf;
>  
> -	for_each_trace_fprobe(tf, pos)
> +	list_for_each_entry(pos, &dyn_event_list, list) {
> +		tf = trace_fprobe_from_dyn(pos);
> +		if (!tf)
> +			continue;
> +
>  		if (strcmp(trace_probe_name(&tf->tp), event) == 0 &&
>  		    strcmp(trace_probe_group_name(&tf->tp), group) == 0)
>  			return tf;
> +	}
> +

Ditto and there is no need to change.

>  	return NULL;
>  }
>  
> @@ -835,7 +947,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  	if (trace_fprobe_is_tracepoint(tf))
>  		return __regsiter_tracepoint_fprobe(tf);
>  
> -	/* TODO: handle filter, nofilter or symbol list */
> +	/* Registration path:
> +	 *  - list_mode: pass filter/nofilter
> +	 *  - single: pass symbol only (legacy)
> +	 */
> +	if (tf->list_mode)
> +		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
>  	return register_fprobe(&tf->fp, tf->symbol, NULL);
>  }
>  
> @@ -1114,7 +1231,11 @@ static int __tprobe_event_module_cb(struct notifier_block *self,
>  		return NOTIFY_DONE;
>  
>  	mutex_lock(&event_mutex);
> -	for_each_trace_fprobe(tf, pos) {
> +	list_for_each_entry(pos, &dyn_event_list, list) {
> +		tf = trace_fprobe_from_dyn(pos);
> +		if (!tf)
> +			continue;
> +
>  		/* Skip fprobe and disabled tprobe events. */
>  		if (!trace_fprobe_is_tracepoint(tf) || !tf->tuser)
>  			continue;
> @@ -1155,55 +1276,35 @@ static int parse_symbol_and_return(int argc, const char *argv[],
>  				   char **symbol, bool *is_return,
>  				   bool is_tracepoint)
>  {
> -	char *tmp = strchr(argv[1], '%');
> -	int i;
> -
> -	if (tmp) {
> -		int len = tmp - argv[1];
> -
> -		if (!is_tracepoint && !strcmp(tmp, "%return")) {
> -			*is_return = true;
> -		} else {
> -			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
> -			return -EINVAL;
> -		}
> -		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
> -	} else
> -		*symbol = kstrdup(argv[1], GFP_KERNEL);
> -	if (!*symbol)
> -		return -ENOMEM;
> -
> -	if (*is_return)
> -		return 0;
> +	int i, ret;
> +	bool list_mode = false;
> +	char *filter = NULL; *nofilter = NULL;

Sort it as other functions. longer line to shorter.

>  
> -	if (is_tracepoint) {
> -		tmp = *symbol;
> -		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
> -			tmp++;
> -		if (*tmp) {
> -			/* find a wrong character. */
> -			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
> -			kfree(*symbol);
> -			*symbol = NULL;
> -			return -EINVAL;
> -		}
> -	}
> +	ret = parse_fprobe_spec(argv[1], is_tracepoint, symbol, is_return,
> +			&list_mode, &filter, &nofilter);
> +	if (ret)
> +		return ret;
>  
> -	/* If there is $retval, this should be a return fprobe. */
>  	for (i = 2; i < argc; i++) {
> -		tmp = strstr(argv[i], "$retval");
> +		char *tmp = strstr(argv[i], "$retval");
> +
>  		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
>  			if (is_tracepoint) {
>  				trace_probe_log_set_index(i);
>  				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
>  				kfree(*symbol);
>  				*symbol = NULL;
> +				kfree(filter);
> +				kfree(nofilter);
>  				return -EINVAL;
>  			}
>  			*is_return = true;
>  			break;
>  		}
>  	}
> +
> +	kfree(filter);
> +	kfree(nofilter);
>  	return 0;
>  }
>  
> @@ -1247,6 +1348,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	int i, new_argc = 0, ret = 0;
>  	bool is_tracepoint = false;
>  	bool is_return = false;
> +	bool list_mode = false;
> +

Do not split local variable definitions with empty lines.

> +	char *parsed_filter __free(kfree) = NULL;
> +	char *parsed_nofilter __free(kfree) = NULL;
> +	bool has_wild = false;

Please sort.

>  
>  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
>  		return -ECANCELED;
> @@ -1267,8 +1373,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  
>  	trace_probe_log_set_index(1);
>  
> -	/* a symbol(or tracepoint) must be specified */
> -	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
> +	/* Parse spec early (single vs list, suffix, base symbol) */
> +	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
> +			&list_mode, &parsed_filter, &parsed_nofilter);

Hmm, if so, where is the parse_symbol_and_return() called?
I think you can pick the $retval search loop from the 
parse_symbol_and_return() for updating is_return (or make
it failure if is_tracepoint == true).

>  	if (ret < 0)
>  		return -EINVAL;
>  
> @@ -1283,10 +1390,16 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  			return -EINVAL;
>  	}
>  
> -	if (!event) {
> -		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> -		if (!ebuf)
> -			return -ENOMEM;
> +		if (!event) {
> +		/*
> +		 * Event name rules:
> +		 * - For list/wildcard: require explicit [GROUP/]EVENT
> +		 * - For single literal: autogenerate symbol__entry/symbol__exit
> +		 */

nit: to avoid confusing, comment should be indented as same as the
code. Or, put the comment right before the `if`.

> +			if (list_mode || has_wildcard(symbol)) {
> +				trace_probe_log_err(0, NO_GROUP_NAME);
> +			return -EINVAL;
> +		}
>  		/* Make a new event name */
>  		if (is_tracepoint)
>  			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
> @@ -1319,7 +1432,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  							NULL, NULL, NULL, sbuf);
>  		}
>  	}
> -	if (!ctx->funcname)
> +
> +	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
>  		ctx->funcname = symbol;
>  
>  	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> @@ -1353,6 +1467,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  		return ret;
>  	}
>  
> +	/* carry list parsing result into tf */
> +	if (!is_tracepoint) {
> +		tf->list_mode = list_mode;
> +			if (parsed_filter) {
> +				tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
> +				if (!tf->filter)
> +					return -ENOMEM;
> +			}
> +			if (parsed_nofilter) {
> +				tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
> +				if (!tf->nofilter)
> +					return -ENOMEM;
> +			}
> +		}

Odd indentation. Please fix.

> +
>  	/* parse arguments */
>  	for (i = 0; i < argc; i++) {
>  		trace_probe_log_set_index(i + 2);
> @@ -1439,8 +1568,16 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
>  	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
>  				trace_probe_name(&tf->tp));
>  
> -	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
> -			       trace_fprobe_is_return(tf) ? "%return" : "");
> +	seq_printf(m, "%s", trace_fprobe_symbol(tf));
> +	if (!trace_fprobe_is_tracepoint(tf)) {
> +		if (tf->list_mode) {
> +			if (trace_fprobe_is_return(tf))
> +				seq_puts(m, ":exit");

In both cases, we can use ":exit" suffix. This means we will
accept legacy "%return" for backward compatibility, but
shows ":exit" always.

> +		} else {
> +			if (trace_fprobe_is_return(tf))
> +				seq_puts(m, "%return");
> +		}
> +	}
>  
>  	for (i = 0; i < tf->tp.nr_args; i++)
>  		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
> -- 
> 2.43.0
> 

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

