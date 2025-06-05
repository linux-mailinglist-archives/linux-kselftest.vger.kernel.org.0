Return-Path: <linux-kselftest+bounces-34368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C661BACEE75
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 13:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DAE3AA900
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A441ACEC7;
	Thu,  5 Jun 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4MdGFbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B4229A2;
	Thu,  5 Jun 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122529; cv=none; b=FBdhuPveH294HoHT2PeVX269Ybztat/uD9Y2IB5Ns/k9MqNdgzQ4yV39dovr0pR6DPKLue0fEIFw0ckmn8nSmxNk27449EE5b4th9AyMChP833wf8djmlIx/sHMtOsK7UpHX9uaTCeZn1i7ZTBnII4Naw84j+2CIG+oQ8lvfKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122529; c=relaxed/simple;
	bh=6KXfWs11fxcem23nR5eKOWtxQHs7PPLz86/5BYnkXOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUfwRfdBnns/WpEnF+e082+ZKjc5KWDi9XB115S2mLxA7BCOsMTPkT/bO0QDY/38gD+TUFTyUPAkmp5rRCx31PLetMdEEDZnnKYogKhTeTK3Ubztn39RkJ5pO0WReAmWz7xF8x51Qw3exqtg/qutk2dAcKwa0MDEpeNNaDHmgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4MdGFbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84997C4CEE7;
	Thu,  5 Jun 2025 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122528;
	bh=6KXfWs11fxcem23nR5eKOWtxQHs7PPLz86/5BYnkXOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m4MdGFbsEO5WKheAGozNxxCDzE3ReRhI+qhChL86dQwKo6FHH52ICPRdUEYmMTkZ/
	 kVyqid8Pf1ZlrO88/VPU4kCEC+xAGa1ECuZUJnsmxRhu2zj90P7bdVh7it5y1CbodB
	 usCP3/v+S5SAePjT3/+zWnVU7LYui+I1GFKMxeuHy5TL3sZawDWIFqW30jLTJsQhyh
	 ssMZhpPSxWx4pHsgfdILrNlsAu9vbzpG3Uc/TlkLGvmXFRYkLNehZZ/FYqtFvCjNAN
	 PHgdMEzPPz1D+TOdNhsJ5vHZeNif7P6GUWrEr95ZTvNsI5GzGJMvzFTIZkMUhC58NB
	 07U/+HF6DDCUw==
Message-ID: <c3b403f5-4849-44f3-82cb-b0b506b10138@kernel.org>
Date: Thu, 5 Jun 2025 12:22:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Use appropriate permissions for
 map access
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250530164844.74734-1-slava.imameev@crowdstrike.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250530164844.74734-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-31 02:48 UTC+1000 ~ Slava Imameev <slava.imameev@crowdstrike.com>
> Modify several functions in tools/bpf/bpftool/common.c to allow
> specification of requested access for file descriptors, such as
> read-only access.
> 
> Update bpftool to request only read access for maps when write
> access is not required. This fixes errors when reading from maps
> that are protected from modification via security_bpf_map.
> 
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>


Thanks for this!

I think the topic of map access in bpftool has been discussed in the
path, but I can't remember what we said or find it again - maybe I don't
remember correctly. Looks good to me overall.

One question: How thoroughly have you tested that write permissions are
necessary for the different cases? I'm asking because I'm wondering
whether we could restrict to read-only in a couple more cases, see
below. (At the end of the day it doesn't matter too much, it's fine
being conservative and conserving write permissions for now, we can
always refine later; it's already an improvement to do read-only for the
dump/list cases).

Please find some additional comments inline below.


> ---
> Changes in v2:
> - fix for a test compilation error: "conflicting types for 'bpf_fentry_test1'"
> ---
> ---
>  tools/bpf/bpftool/btf.c           |  3 +-
>  tools/bpf/bpftool/common.c        | 57 ++++++++++++++++++++++---------
>  tools/bpf/bpftool/iter.c          |  2 +-
>  tools/bpf/bpftool/link.c          |  2 +-
>  tools/bpf/bpftool/main.h          | 13 ++++---
>  tools/bpf/bpftool/map.c           | 56 +++++++++++++++++-------------
>  tools/bpf/bpftool/map_perf_ring.c |  3 +-
>  tools/bpf/bpftool/prog.c          |  4 +--
>  8 files changed, 90 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6b14cbfa58aa..1ba27cb03348 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -905,7 +905,8 @@ static int do_dump(int argc, char **argv)
>  			return -1;
>  		}
>  
> -		fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +		fd = map_parse_fd_and_info(&argc, &argv, &info, &len,
> +					   BPF_F_RDONLY);
>  		if (fd < 0)
>  			return -1;
>  
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index ecfa790adc13..ff1c99281beb 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -193,7 +193,8 @@ int mount_tracefs(const char *target)
>  	return err;
>  }
>  
> -int open_obj_pinned(const char *path, bool quiet)
> +int open_obj_pinned(const char *path, bool quiet,
> +		    const struct bpf_obj_get_opts *opts)
>  {
>  	char *pname;
>  	int fd = -1;
> @@ -205,7 +206,7 @@ int open_obj_pinned(const char *path, bool quiet)
>  		goto out_ret;
>  	}
>  
> -	fd = bpf_obj_get(pname);
> +	fd = bpf_obj_get_opts(pname, opts);
>  	if (fd < 0) {
>  		if (!quiet)
>  			p_err("bpf obj get (%s): %s", pname,
> @@ -221,12 +222,13 @@ int open_obj_pinned(const char *path, bool quiet)
>  	return fd;
>  }
>  
> -int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
> +int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
> +			const struct bpf_obj_get_opts *opts)
>  {
>  	enum bpf_obj_type type;
>  	int fd;
>  
> -	fd = open_obj_pinned(path, false);
> +	fd = open_obj_pinned(path, false, opts);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -555,7 +557,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
>  	if (typeflag != FTW_F)
>  		goto out_ret;
>  
> -	fd = open_obj_pinned(fpath, true);
> +	fd = open_obj_pinned(fpath, true, NULL);
>  	if (fd < 0)
>  		goto out_ret;
>  
> @@ -928,7 +930,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
>  		path = **argv;
>  		NEXT_ARGP();
>  
> -		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG);
> +		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_PROG, NULL);
>  		if ((*fds)[0] < 0)
>  			return -1;
>  		return 1;
> @@ -965,7 +967,8 @@ int prog_parse_fd(int *argc, char ***argv)
>  	return fd;
>  }
>  
> -static int map_fd_by_name(char *name, int **fds)
> +static int map_fd_by_name(char *name, int **fds,
> +			  const struct bpf_get_fd_by_id_opts *opts)
>  {
>  	unsigned int id = 0;
>  	int fd, nb_fds = 0;
> @@ -973,6 +976,7 @@ static int map_fd_by_name(char *name, int **fds)
>  	int err;
>  
>  	while (true) {
> +		LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts_ro);
>  		struct bpf_map_info info = {};
>  		__u32 len = sizeof(info);
>  
> @@ -985,7 +989,9 @@ static int map_fd_by_name(char *name, int **fds)
>  			return nb_fds;
>  		}
>  
> -		fd = bpf_map_get_fd_by_id(id);
> +		/* Request a read-only fd to query the map info */
> +		opts_ro.open_flags = BPF_F_RDONLY;
> +		fd = bpf_map_get_fd_by_id_opts(id, &opts_ro);
>  		if (fd < 0) {
>  			p_err("can't get map by id (%u): %s",
>  			      id, strerror(errno));
> @@ -1004,6 +1010,15 @@ static int map_fd_by_name(char *name, int **fds)
>  			continue;
>  		}
>  
> +		/* Get an fd with the requested options. */
> +		close(fd);
> +		fd = bpf_map_get_fd_by_id_opts(id, opts);
> +		if (fd < 0) {
> +			p_err("can't get map by id (%u): %s", id,
> +			      strerror(errno));
> +			goto err_close_fds;
> +		}


We could maybe skip this step if the requested options are read-only, no
need to close and re-open a fd in that case?


> +
>  		if (nb_fds > 0) {
>  			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
>  			if (!tmp) {
> @@ -1023,8 +1038,16 @@ static int map_fd_by_name(char *name, int **fds)
>  	return -1;
>  }
>  
> -int map_parse_fds(int *argc, char ***argv, int **fds)
> +int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags)
>  {
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
> +
> +	if (open_flags & ~BPF_F_RDONLY) {
> +		p_err("invalid open_flags: %x", open_flags);
> +		return -1;
> +	}


I don't think we need this check, the flag is never passed by users. If
you want to catch a bug, use an assert() instead?


> +	opts.open_flags = open_flags;
> +
>  	if (is_prefix(**argv, "id")) {
>  		unsigned int id;
>  		char *endptr;
> @@ -1038,7 +1061,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
>  		}
>  		NEXT_ARGP();
>  
> -		(*fds)[0] = bpf_map_get_fd_by_id(id);
> +		(*fds)[0] = bpf_map_get_fd_by_id_opts(id, &opts);
>  		if ((*fds)[0] < 0) {
>  			p_err("get map by id (%u): %s", id, strerror(errno));
>  			return -1;
> @@ -1056,16 +1079,18 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
>  		}
>  		NEXT_ARGP();
>  
> -		return map_fd_by_name(name, fds);
> +		return map_fd_by_name(name, fds, &opts);
>  	} else if (is_prefix(**argv, "pinned")) {
>  		char *path;
> +		LIBBPF_OPTS(bpf_obj_get_opts, get_opts);
> +		get_opts.file_flags = open_flags;
>  
>  		NEXT_ARGP();
>  
>  		path = **argv;
>  		NEXT_ARGP();
>  
> -		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP);
> +		(*fds)[0] = open_obj_pinned_any(path, BPF_OBJ_MAP, &get_opts);
>  		if ((*fds)[0] < 0)
>  			return -1;
>  		return 1;
> @@ -1075,7 +1100,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds)
>  	return -1;
>  }
>  
> -int map_parse_fd(int *argc, char ***argv)
> +int map_parse_fd(int *argc, char ***argv, __u32 open_flags)
>  {
>  	int *fds = NULL;
>  	int nb_fds, fd;
> @@ -1085,7 +1110,7 @@ int map_parse_fd(int *argc, char ***argv)
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
> -	nb_fds = map_parse_fds(argc, argv, &fds);
> +	nb_fds = map_parse_fds(argc, argv, &fds, open_flags);
>  	if (nb_fds != 1) {
>  		if (nb_fds > 1) {
>  			p_err("several maps match this handle");
> @@ -1103,12 +1128,12 @@ int map_parse_fd(int *argc, char ***argv)
>  }
>  
>  int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
> -			  __u32 *info_len)
> +			  __u32 *info_len, __u32 open_flags)
>  {
>  	int err;
>  	int fd;
>  
> -	fd = map_parse_fd(argc, argv);
> +	fd = map_parse_fd(argc, argv, open_flags);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
> index 5c39c2ed36a2..ad318a8667a4 100644
> --- a/tools/bpf/bpftool/iter.c
> +++ b/tools/bpf/bpftool/iter.c
> @@ -37,7 +37,7 @@ static int do_pin(int argc, char **argv)
>  				return -1;
>  			}
>  
> -			map_fd = map_parse_fd(&argc, &argv);
> +			map_fd = map_parse_fd(&argc, &argv, 0);


Do you need write permissions here? (I don't remember.)


>  			if (map_fd < 0)
>  				return -1;
>  
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 3535afc80a49..8523be11dcd9 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -117,7 +117,7 @@ static int link_parse_fd(int *argc, char ***argv)
>  		path = **argv;
>  		NEXT_ARGP();
>  
> -		return open_obj_pinned_any(path, BPF_OBJ_LINK);
> +		return open_obj_pinned_any(path, BPF_OBJ_LINK, NULL);
>  	}
>  
>  	p_err("expected 'id' or 'pinned', got: '%s'?", **argv);
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 9eb764fe4cc8..6db704fda5c0 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -15,6 +15,7 @@
>  
>  #include <bpf/hashmap.h>
>  #include <bpf/libbpf.h>
> +#include <bpf/bpf.h>
>  
>  #include "json_writer.h"
>  
> @@ -140,8 +141,10 @@ void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_fd,
>  int get_fd_type(int fd);
>  const char *get_fd_type_name(enum bpf_obj_type type);
>  char *get_fdinfo(int fd, const char *key);
> -int open_obj_pinned(const char *path, bool quiet);
> -int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
> +int open_obj_pinned(const char *path, bool quiet,
> +		    const struct bpf_obj_get_opts *opts);
> +int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type,
> +			const struct bpf_obj_get_opts *opts);
>  int mount_bpffs_for_file(const char *file_name);
>  int create_and_mount_bpffs_dir(const char *dir_name);
>  int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
> @@ -167,10 +170,10 @@ int do_iter(int argc, char **argv) __weak;
>  int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
>  int prog_parse_fd(int *argc, char ***argv);
>  int prog_parse_fds(int *argc, char ***argv, int **fds);
> -int map_parse_fd(int *argc, char ***argv);
> -int map_parse_fds(int *argc, char ***argv, int **fds);
> +int map_parse_fd(int *argc, char ***argv, __u32 open_flags);
> +int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags);
>  int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
> -			  __u32 *info_len);
> +			  __u32 *info_len, __u32 open_flags);
>  
>  struct bpf_prog_linfo;
>  #if defined(HAVE_LLVM_SUPPORT) || defined(HAVE_LIBBFD_SUPPORT)
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 81cc668b4b05..c7dc2eae8ba8 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -337,9 +337,9 @@ static void fill_per_cpu_value(struct bpf_map_info *info, void *value)
>  		memcpy(value + i * step, value, info->value_size);
>  }
>  
> -static int parse_elem(char **argv, struct bpf_map_info *info,
> -		      void *key, void *value, __u32 key_size, __u32 value_size,
> -		      __u32 *flags, __u32 **value_fd)
> +static int parse_elem(char **argv, struct bpf_map_info *info, void *key,
> +		      void *value, __u32 key_size, __u32 value_size,
> +		      __u32 *flags, __u32 **value_fd, __u32 open_flags)
>  {
>  	if (!*argv) {
>  		if (!key && !value)
> @@ -362,7 +362,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
>  			return -1;
>  
>  		return parse_elem(argv, info, NULL, value, key_size, value_size,
> -				  flags, value_fd);
> +				  flags, value_fd, open_flags);
>  	} else if (is_prefix(*argv, "value")) {
>  		int fd;
>  
> @@ -388,7 +388,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
>  				return -1;
>  			}
>  
> -			fd = map_parse_fd(&argc, &argv);
> +			fd = map_parse_fd(&argc, &argv, open_flags);
>  			if (fd < 0)
>  				return -1;
>  
> @@ -424,7 +424,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
>  		}
>  
>  		return parse_elem(argv, info, key, NULL, key_size, value_size,
> -				  flags, NULL);
> +				  flags, NULL, open_flags);
>  	} else if (is_prefix(*argv, "any") || is_prefix(*argv, "noexist") ||
>  		   is_prefix(*argv, "exist")) {
>  		if (!flags) {
> @@ -440,7 +440,7 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
>  			*flags = BPF_EXIST;
>  
>  		return parse_elem(argv + 1, info, key, value, key_size,
> -				  value_size, NULL, value_fd);
> +				  value_size, NULL, value_fd, open_flags);
>  	}
>  
>  	p_err("expected key or value, got: %s", *argv);
> @@ -639,7 +639,7 @@ static int do_show_subset(int argc, char **argv)
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
> -	nb_fds = map_parse_fds(&argc, &argv, &fds);
> +	nb_fds = map_parse_fds(&argc, &argv, &fds, BPF_F_RDONLY);
>  	if (nb_fds < 1)
>  		goto exit_free;
>  
> @@ -672,12 +672,15 @@ static int do_show_subset(int argc, char **argv)
>  
>  static int do_show(int argc, char **argv)
>  {
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
>  	struct bpf_map_info info = {};
>  	__u32 len = sizeof(info);
>  	__u32 id = 0;
>  	int err;
>  	int fd;
>  
> +	opts.open_flags = BPF_F_RDONLY;
> +
>  	if (show_pinned) {
>  		map_table = hashmap__new(hash_fn_for_key_as_id,
>  					 equal_fn_for_key_as_id, NULL);
> @@ -707,7 +710,7 @@ static int do_show(int argc, char **argv)
>  			break;
>  		}
>  
> -		fd = bpf_map_get_fd_by_id(id);
> +		fd = bpf_map_get_fd_by_id_opts(id, &opts);
>  		if (fd < 0) {
>  			if (errno == ENOENT)
>  				continue;
> @@ -909,7 +912,7 @@ static int do_dump(int argc, char **argv)
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
> -	nb_fds = map_parse_fds(&argc, &argv, &fds);
> +	nb_fds = map_parse_fds(&argc, &argv, &fds, BPF_F_RDONLY);
>  	if (nb_fds < 1)
>  		goto exit_free;
>  
> @@ -997,7 +1000,7 @@ static int do_update(int argc, char **argv)
>  	if (argc < 2)
>  		usage();
>  
> -	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, 0);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -1006,7 +1009,7 @@ static int do_update(int argc, char **argv)
>  		goto exit_free;
>  
>  	err = parse_elem(argv, &info, key, value, info.key_size,
> -			 info.value_size, &flags, &value_fd);
> +			 info.value_size, &flags, &value_fd, 0);
>  	if (err)
>  		goto exit_free;
>  
> @@ -1076,7 +1079,7 @@ static int do_lookup(int argc, char **argv)
>  	if (argc < 2)
>  		usage();
>  
> -	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, BPF_F_RDONLY);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -1084,7 +1087,8 @@ static int do_lookup(int argc, char **argv)
>  	if (err)
>  		goto exit_free;
>  
> -	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL);
> +	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL,
> +			 BPF_F_RDONLY);
>  	if (err)
>  		goto exit_free;
>  
> @@ -1127,7 +1131,7 @@ static int do_getnext(int argc, char **argv)
>  	if (argc < 2)
>  		usage();
>  
> -	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, BPF_F_RDONLY);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -1140,8 +1144,8 @@ static int do_getnext(int argc, char **argv)
>  	}
>  
>  	if (argc) {
> -		err = parse_elem(argv, &info, key, NULL, info.key_size, 0,
> -				 NULL, NULL);
> +		err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL,
> +				 NULL, BPF_F_RDONLY);
>  		if (err)
>  			goto exit_free;
>  	} else {
> @@ -1198,7 +1202,7 @@ static int do_delete(int argc, char **argv)
>  	if (argc < 2)
>  		usage();
>  
> -	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, BPF_F_RDONLY);


This one is surprising, don't you need write permissions to delete an
element from the map? Please double-check if you haven't already, I
wouldn't want to break "bpftool map delete".

I note you don't test items deletion in your tests, by the way.


>  	if (fd < 0)
>  		return -1;
>  
> @@ -1209,7 +1213,8 @@ static int do_delete(int argc, char **argv)
>  		goto exit_free;
>  	}
>  
> -	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL);
> +	err = parse_elem(argv, &info, key, NULL, info.key_size, 0, NULL, NULL,
> +			 0);
>  	if (err)
>  		goto exit_free;
>  
> @@ -1226,11 +1231,16 @@ static int do_delete(int argc, char **argv)
>  	return err;
>  }
>  
> +static int map_parse_read_only_fd(int *argc, char ***argv)
> +{
> +	return map_parse_fd(argc, argv, BPF_F_RDONLY);
> +}
> +
>  static int do_pin(int argc, char **argv)
>  {
>  	int err;
>  
> -	err = do_pin_any(argc, argv, map_parse_fd);
> +	err = do_pin_any(argc, argv, map_parse_read_only_fd);
>  	if (!err && json_output)
>  		jsonw_null(json_wtr);
>  	return err;
> @@ -1319,7 +1329,7 @@ static int do_create(int argc, char **argv)
>  			if (!REQ_ARGS(2))
>  				usage();
>  			inner_map_fd = map_parse_fd_and_info(&argc, &argv,
> -							     &info, &len);
> +							     &info, &len, 0);


Do you need write permissions for the inner map's fd? This is something
that could be worth checking in the tests, as well.


>  			if (inner_map_fd < 0)
>  				return -1;
>  			attr.inner_map_fd = inner_map_fd;
> @@ -1368,7 +1378,7 @@ static int do_pop_dequeue(int argc, char **argv)
>  	if (argc < 2)
>  		usage();
>  
> -	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, 0);
>  	if (fd < 0)
>  		return -1;
>  
> @@ -1407,7 +1417,7 @@ static int do_freeze(int argc, char **argv)
>  	if (!REQ_ARGS(2))
>  		return -1;
>  
> -	fd = map_parse_fd(&argc, &argv);
> +	fd = map_parse_fd(&argc, &argv, 0);
>  	if (fd < 0)
>  		return -1;
>  
> diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
> index 552b4ca40c27..bcb767e2d673 100644
> --- a/tools/bpf/bpftool/map_perf_ring.c
> +++ b/tools/bpf/bpftool/map_perf_ring.c
> @@ -128,7 +128,8 @@ int do_event_pipe(int argc, char **argv)
>  	int err, map_fd;
>  
>  	map_info_len = sizeof(map_info);
> -	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len);
> +	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
> +				       0);


This one might be worth checking, too.


>  	if (map_fd < 0)
>  		return -1;
>  
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 96eea8a67225..deeaa5c1ed7d 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1062,7 +1062,7 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
>  	if (!REQ_ARGS(2))
>  		return -EINVAL;
>  
> -	*mapfd = map_parse_fd(&argc, &argv);
> +	*mapfd = map_parse_fd(&argc, &argv, 0);
>  	if (*mapfd < 0)
>  		return *mapfd;
>  
> @@ -1608,7 +1608,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  			}
>  			NEXT_ARG();
>  
> -			fd = map_parse_fd(&argc, &argv);
> +			fd = map_parse_fd(&argc, &argv, 0);
>  			if (fd < 0)
>  				goto err_free_reuse_maps;
>  


